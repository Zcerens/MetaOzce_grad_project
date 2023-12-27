import requests
from bs4 import BeautifulSoup
import sqlite3

# Ana sayfa URL'si
ana_sayfa_url = 'https://www.tatilsepeti.com/antalya-otelleri?ara=oda:2&filtreler=altbolge:13'

response = requests.get(ana_sayfa_url)

if response.status_code == 200:
    content = response.content
    soup = BeautifulSoup(content, 'html.parser')

    # Ana sayfadaki otel URL'lerini bulma
    otel_urls = []
    otel_butonlari = soup.find_all('a', class_='btn btn-block btn-primary')
    for otel_buton in otel_butonlari:
        otel_url = 'https://www.tatilsepeti.com' + otel_buton['href']
        otel_urls.append(otel_url)

    # Her bir otel detay sayfasından verileri çekme
    for otel_url in otel_urls:
        otel_response = requests.get(otel_url)

        if otel_response.status_code == 200:
            otel_content = otel_response.content
            otel_soup = BeautifulSoup(otel_content, 'html.parser')

            # Otel Özellikleri başlığı altındaki verileri çekme
            otel_ozellikleri = otel_soup.find('div', class_='row room-spect mt-15')

            # Konum Bilgileri başlığı altındaki verileri çekme
            konum_bilgileri = otel_soup.find('div', class_='detail-title')

            # Ücretsiz Aktiviteler başlığı altındaki verileri çekme
            ucretsiz_aktiviteler = otel_soup.find('div', class_='row free-activities')

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
