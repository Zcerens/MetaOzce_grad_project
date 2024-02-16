import requests
from bs4 import BeautifulSoup
import sqlite3

main_url = 'https://www.tatilsepeti.com/yurtici-oteller'
base_url = 'https://www.tatilsepeti.com/yurtici-oteller?sayfa={}'

# SQLite veritabanına bağlanma
conn = sqlite3.connect('hotelDB1.db')
cursor = conn.cursor()

# Tablo oluşturma (Eğer tablo henüz oluşturulmamışsa)
cursor.execute('''
    CREATE TABLE IF NOT EXISTS otel (
        otel_ad TEXT,
        "Hava Alanına Uzaklığı" TEXT DEFAULT "No Info",
        "Denize Uzaklığı" TEXT DEFAULT "No Info",
        "Sahil Uzunluğu" TEXT DEFAULT "No Info",
        "Plaj" TEXT DEFAULT "No Info",  
        "İskele" TEXT DEFAULT "No Info",   
        "A la Carte Restoran" TEXT DEFAULT "0",
        "Açık Restoran" TEXT DEFAULT "0",
        "Kapalı Restoran" TEXT DEFAULT "0",
        "Açık Havuz" TEXT DEFAULT "0",
        "Kapalı Havuz" TEXT DEFAULT "0",
        "Asansör" TEXT DEFAULT "0",
        "Bedensel Engelli Odası" TEXT DEFAULT "0",
        "Market" TEXT DEFAULT "0",
        "Su Kaydırağı" TEXT DEFAULT "0",
        "Sauna" TEXT DEFAULT "0",
        "Doktor" TEXT DEFAULT "0",
        "Çocuk Havuzu" TEXT DEFAULT "0",
        "Çocuk Parkı" TEXT DEFAULT "0"
    )
''')

# Ana sayfa ve diğer sayfaları ziyaret etme
for page_number in range(1, 170):  # Örneğin 10 sayfa varsa
    if page_number == 1:
        page_url = main_url
    else:
        page_url = base_url.format(page_number)
    response = requests.get(page_url)

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
        for otel_url in otel_urls:  # İlk 20 oteli al
            otel_response = requests.get(otel_url)

            if otel_response.status_code == 200:
                otel_content = otel_response.content
                otel_soup = BeautifulSoup(otel_content, 'html.parser')

                # Otel adını çekme
                otel_ad_element = otel_soup.find('h1', class_='hotel__name pull-left')
                otel_ad = otel_ad_element.text.strip() if otel_ad_element else 'Bilinmeyen Otel Adı'

                # Veritabanında aynı otel adı var mı kontrol etme
                cursor.execute('SELECT * FROM otel WHERE otel_ad = ?', (otel_ad,))
                existing_data = cursor.fetchone()

                if existing_data is None:
                    # Veritabanına ekleme
                    cursor.execute('INSERT INTO otel (otel_ad) VALUES (?)', (otel_ad,))
                    
                    # Otel Özellikleri başlığı altındaki verileri çekme
                    konum_bilgileri = otel_soup.find('div', class_='row location-info')
                    otel_ozellikleri = otel_soup.find('div', class_='row room-spect mt-15') 
                    ucretsiz_aktiviteler = otel_soup.find('div', class_='row free-activities')
                    ucretli_aktiviteler = otel_soup.find('div', class_='row paid-activities')                
                    cocuk_aktiviteleri = otel_soup.find('div', class_='row activities-for-children')

                    if konum_bilgileri:
                        # Mevcut sütun adlarını al
                        cursor.execute('PRAGMA table_info(otel)')
                        columns = cursor.fetchall()
                        column_names = [column[1] for column in columns]
                        konum_tablosu = konum_bilgileri.find_next('table')
                        if konum_tablosu:
                            konum_bilgileri_listesi = konum_tablosu.find_all('tr')
                            for bilgi in konum_bilgileri_listesi:
                                th_list = bilgi.find_all('th', class_='location-info__title')
                                td_list = bilgi.find_all('td')
                                for i in range(len(th_list)):
                                    baslik = th_list[i].text.strip() if i < len(th_list) else ''
                                    deger = td_list[i].text.strip() if i < len(td_list) else ''
                                    # ":" karakterini kaldırma
                                    baslik = baslik.split(':')[0]
                                    if baslik in column_names:
                                        cursor.execute(f'UPDATE otel SET "{baslik}" = ? WHERE otel_ad = ?', (deger, otel_ad))

                    # Otel Özellikleri başlığı altındaki verileri çekme
                    for ozellik in [otel_ozellikleri,ucretsiz_aktiviteler,ucretli_aktiviteler,cocuk_aktiviteleri]:
                        if ozellik:
                            # Otel Özellikleri listesini çekme
                            otel_ozellikleri_listesi = ozellik.find('ul')
                            if otel_ozellikleri_listesi:
                                # Mevcut sütun adlarını al
                                cursor.execute('PRAGMA table_info(otel)')
                                columns = cursor.fetchall()
                                column_names = [column[1] for column in columns]

                                for li in otel_ozellikleri_listesi.find_all('li'):
                                    ozellik = li.text.strip()
                                    
                                    # Eğer özelliğin yanında adet belirtiliyorsa, adedi al, aksi halde 1 kabul et
                                    adet = 1
                                
                                    if '(' in ozellik:
                                        adet_firstindex = ozellik.find('(')
                                        adet_lastindex = ozellik.find(' Adet')
                                        if adet_firstindex > 0:
                                            ozellik_adi = ozellik[:adet_firstindex].strip()
                                            if ozellik_adi in column_names:
                                                adet_str = ozellik[adet_firstindex+1:adet_lastindex].strip()
                                                adet = adet_str

                                                # Mevcut sütun adıyla eşleşen özellikler için değeri güncelleme
                                                cursor.execute(f'UPDATE otel SET "{ozellik_adi}" = ? WHERE otel_ad = ?', (adet, otel_ad))
                                    else: 
                                        if ozellik in column_names:
                                            cursor.execute(f'UPDATE otel SET "{ozellik}" = ? WHERE otel_ad = ?', (adet, otel_ad))

        # Değişiklikleri kaydetme
        conn.commit()

# Bağlantıyı kapatma
conn.close()
