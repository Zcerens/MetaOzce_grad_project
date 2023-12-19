import requests
from bs4 import BeautifulSoup
import sqlite3

url = 'https://www.tatilsepeti.com/crystal-de-luxe-resort-spa?RT=5'
response = requests.get(url)

if response.status_code == 200:
    content = response.content
    soup = BeautifulSoup(content, 'html.parser')

    # Otel Özellikleri başlığı altındaki verileri çekme
    otel_ozellikleri = soup.find('div', class_='row room-spect mt-15')
    
    # Konum Bilgileri başlığı altındaki verileri çekme
    konum_bilgileri = soup.find('div', class_='detail-title')
    
    # Ücretsiz Aktiviteler başlığı altındaki verileri çekme
    ucretsiz_aktiviteler = soup.find('div', class_='row free-activities')

    # SQLite veritabanına bağlanma
    conn = sqlite3.connect('otel_veritabani.db')
    cursor = conn.cursor()

    # Tablo oluşturma (Eğer tablo henüz oluşturulmamışsa)
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS otel (
            ozellik TEXT
        )
    ''')

    if otel_ozellikleri:
        # Otel Özellikleri listesini çekme
        print("\n******OTEL OZELLIKLERI**********")
        otel_ozellikleri_listesi = otel_ozellikleri.find('ul')
        if otel_ozellikleri_listesi:
            for li in otel_ozellikleri_listesi.find_all('li'):
                ozellik = li.text.strip()
                print(ozellik)

                # Veritabanında aynı veri var mı kontrol etme
                cursor.execute('SELECT * FROM otel WHERE ozellik = ?', (ozellik,))
                existing_data = cursor.fetchone()

                if existing_data is None:
                    # Veritabanına ekleme
                    cursor.execute('INSERT INTO otel (ozellik) VALUES (?)', (ozellik,))

    if konum_bilgileri:
        print("\n******KONUM BİLGİLERİ**********")
        # Tablo içindeki tüm satırları çekme
        table_rows = konum_bilgileri.find_next('table').find('tbody').find_all('tr')

        for row in table_rows:
            # Her bir satırdaki başlık ve değeri çekme
            title = row.find('th', class_='location-info__title').text.strip()
            value = row.find('td').text.strip()
            print(f'{title}: {value}')

            # Veritabanında aynı veri var mı kontrol etme
            cursor.execute('SELECT * FROM otel WHERE ozellik = ?', (f'{title}: {value}',))
            existing_data = cursor.fetchone()

            if existing_data is None:
                # Veritabanına ekleme
                cursor.execute('INSERT INTO otel (ozellik) VALUES (?)', (f'{title}: {value}',))
                
    if ucretsiz_aktiviteler:
        print("\n******ÜCRETSİZ AKTİVİTELER**********")    
        ucretsiz_aktiviteler_listesi = ucretsiz_aktiviteler.find('ul')
        if ucretsiz_aktiviteler_listesi:
            for li in ucretsiz_aktiviteler_listesi.find_all('li'):
                ucretsiz_aktivite = li.text.strip()
                print(ucretsiz_aktivite)

                # Veritabanında aynı veri var mı kontrol etme
                cursor.execute('SELECT * FROM otel WHERE ozellik = ?', (ucretsiz_aktivite,))
                existing_data = cursor.fetchone()

                if existing_data is None:
                    # Veritabanına ekleme
                    cursor.execute('INSERT INTO otel (ozellik) VALUES (?)', (ucretsiz_aktivite,))

    # Değişiklikleri kaydetme
    conn.commit()

    # Bağlantıyı kapatma
    conn.close()
