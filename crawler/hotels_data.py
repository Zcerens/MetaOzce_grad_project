import time
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from bs4 import BeautifulSoup
import sqlite3
import re
# Chrome WebDriver'ı başlatma
driver = webdriver.Chrome()

main_url = 'https://www.tatilsepeti.com/yurtici-oteller?ara=oda:1;tarih:24.04.2024,30.04.2024&filtreler=bolge:8,24,60,101'
base_url = 'https://www.tatilsepeti.com/yurtici-oteller?sayfa={}&filtreler=bolge:8,24,60,101&ara=oda:1;tarih:24.04.2024,30.04.2024'
# SQLite veritabanına bağlanma
conn = sqlite3.connect('hotelDB26.db')
cursor = conn.cursor()

# Tablo oluşturma (Eğer tablo henüz oluşturulmamışsa)
cursor.execute('''
    CREATE TABLE IF NOT EXISTS otel (
        otel_ad TEXT,       
        fiyat TEXT, 
        "Fiyat Aralığı" TEXT DEFAULT "Null",
        "Bölge" TEXT DEFAULT "Null",
        "Hava Alanına Uzaklığı" TEXT DEFAULT "Null",
        "Denize Uzaklığı" TEXT DEFAULT "Null",
        "Plaj" TEXT DEFAULT "Null",  
        "İskele" TEXT DEFAULT "Null",   
        "A la Carte Restoran" TEXT DEFAULT "0",
        "Asansör" TEXT DEFAULT "0",     
        "Açık Restoran" TEXT DEFAULT "0",
        "Kapalı Restoran" TEXT DEFAULT "0",
        "Açık Havuz" TEXT DEFAULT "0",
        "Kapalı Havuz" TEXT DEFAULT "0",
        "Bedensel Engelli Odası" TEXT DEFAULT "0",
        "Bar" TEXT DEFAULT "0",
        "Su Kaydırağı" TEXT DEFAULT "0",     
        "Balo Salonu" TEXT DEFAULT "0",     
        "Kuaför" TEXT DEFAULT "0",
        "Otopark" TEXT DEFAULT "0",      
        "Market" TEXT DEFAULT "0",
        "Sauna" TEXT DEFAULT "0",
        "Doktor" TEXT DEFAULT "0",
        "Beach Voley" TEXT DEFAULT "0",
        "Fitness" TEXT DEFAULT "0",
        "Canlı Eğlence" TEXT DEFAULT "0",
        "Wireless Internet" TEXT DEFAULT "0",
        "Animasyon" TEXT DEFAULT "0",
        "Sörf" TEXT DEFAULT "0",
        "Paraşüt" TEXT DEFAULT "0",
        "Araç Kiralama" TEXT DEFAULT "0",
        "Kano" TEXT DEFAULT "0",
        "SPA" TEXT DEFAULT "0",
        "Masaj" TEXT DEFAULT "0",
        "Masa Tenisi" TEXT DEFAULT "0",
        "Çocuk Havuzu" TEXT DEFAULT "0",
        "Çocuk Parkı" TEXT DEFAULT "0"
    )
''')

# Ana sayfa ve diğer sayfaları ziyaret etme
for page_number in range(1, 53):  #53
    
    if page_number == 1:
        page_url = main_url
    else:
        page_url = base_url.format(page_number)
        
    driver.get(page_url)
    

    # Sayfanın tamamen yüklendiğinden emin olmak için bir süre bekleyin (Selenium'un bekleme fonksiyonları kullanılır)
    WebDriverWait(driver, 20).until(EC.presence_of_element_located((By.CLASS_NAME, 'discount-price')))

    # Sayfanın tamamını kaydırmak için Javascript kullanıyoruz.
    driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
    time.sleep(3)  # Yükleme tamamlanması için biraz bekleyin

    # Sayfanın kaynak kodunu al
    content = driver.page_source
    soup = BeautifulSoup(content, 'html.parser')

    # Ana sayfadaki otel URL'lerini ve fiyatlarını bulma
    otel_infos = []
    hotel_list = soup.find('div', id='HotelList')  # id="HotelList" olan div'i bul
    otel_names = hotel_list.find_all('div', class_='panel-heading')
    
    otel_butons = soup.find_all('a', class_='btn btn-block btn-primary')
    otel_prices = soup.find_all('p', class_='discount-price')
 
    for otel_name, otel_buton, fiyat in zip(otel_names, otel_butons, otel_prices):
        otel_url = 'https://www.tatilsepeti.com' + otel_buton['href']
        otel_ad = otel_name.text.strip().split('\n\n\n')[0]
        fiyat = fiyat.text.strip()
        otel_infos.append((otel_ad, fiyat, otel_url))

    # Her bir otel detay sayfasından verileri çekme
    for otel_info in otel_infos:
        otel_ad, fiyat, otel_url = otel_info
        driver.get(otel_url)
      
        # Sayfanın tamamen yüklendiğinden emin olmak için bir süre bekleyin (Selenium'un bekleme fonksiyonları kullanılır)
        WebDriverWait(driver, 20).until(EC.presence_of_element_located((By.CLASS_NAME, 'hotel')))

        otel_content = driver.page_source
        otel_soup = BeautifulSoup(otel_content, 'html.parser')

        # Veritabanında aynı otel adı var mı kontrol etme
        cursor.execute('SELECT * FROM otel WHERE otel_ad = ?', (otel_ad,))
        existing_data = cursor.fetchone()

        if existing_data is None:
            # Veritabanına ekleme
            cursor.execute('INSERT INTO otel (otel_ad, fiyat) VALUES (?, ?)', (otel_ad, fiyat))
            
             # Fiyat aralığını kontrol etme ve veritabanına kaydetme
            fiyat = int(fiyat.split(',')[0].replace('.', ''))
            if 5000 < fiyat <= 7000:
                fiyat_araligi = "5000-7000"
            elif 7000 < fiyat <= 9000:
                fiyat_araligi = "7000-9000"
            elif 9000 < fiyat <= 11000:
                fiyat_araligi = "9000-11000"
            elif 11000 < fiyat <= 13000:
                fiyat_araligi = "11000-13000"
            elif 13000 < fiyat <= 15000:
                fiyat_araligi = "13000-15000"
            elif 15000 < fiyat <= 17000:
                fiyat_araligi = "15000-17000"
            elif 17000 < fiyat <= 19000:
                fiyat_araligi = "17000-19000"
            elif 19000 < fiyat <= 21000:
                fiyat_araligi = "19000-21000"
            elif 21000 < fiyat <= 23000:
                fiyat_araligi = "21000-23000"
            elif 23000 < fiyat <= 25000:
                fiyat_araligi = "23000-25000"
            elif 25000 < fiyat <= 27000:
                fiyat_araligi = "25000-27000"
            elif 27000 < fiyat <= 29000:
                fiyat_araligi = "27000-29000"
            elif 29000 < fiyat <= 31000:
                fiyat_araligi = "29000-31000"
            elif 31000 < fiyat <= 33000:
                fiyat_araligi = "29000-33000"
            else:
                fiyat_araligi = "+33000"

            cursor.execute('UPDATE otel SET "Fiyat Aralığı" = ? WHERE otel_ad = ?', (fiyat_araligi, otel_ad))


            # Otel adını çekme
            otel_region = otel_soup.find('h1', class_='hotel__name pull-left')
            otel_ad = otel_region.text.strip() if otel_region else 'Bilinmeyen Otel Adı'
                    
            # Otel Özellikleri başlığı altındaki verileri çekme
            konum_bilgileri = otel_soup.find('div', class_='row location-info')
            otel_ozellikleri = otel_soup.find('div', class_='row room-spect mt-15') 
            ucretsiz_aktiviteler = otel_soup.find('div', class_='row free-activities')
            ucretli_aktiviteler = otel_soup.find('div', class_='row paid-activities')                
            cocuk_aktiviteleri = otel_soup.find('div', class_='row activities-for-children')

            # Bölge bilgisini çekme
            bölge = otel_soup.find('div', class_='hotel__region')
            if bölge:
                bölge_text = bölge.get_text(strip=True).split('Haritada Görüntüle')[0:]
                bölge_metni = ' '.join(bölge_text)
                cursor.execute('UPDATE otel SET "Bölge" = ? WHERE otel_ad = ?', (bölge_metni, otel_ad))

            if konum_bilgileri:
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
                            baslik = baslik.split(':')[0]
                            if baslik in column_names:
                                if baslik == "Hava Alanına Uzaklığı":
                                    sayi = re.findall(r'\d+', deger)
                                    uzaklik = sayi[0] if sayi else "No Info"
                                    havaalani_adi_search = re.search(r'([^0-9]+)', deger)
                                    havaalani_adi = havaalani_adi_search.group(0) if havaalani_adi_search else "No Info"
                                    uzaklik_metni = f"{uzaklik} km, {havaalani_adi}"
                                    cursor.execute('UPDATE otel SET "Hava Alanına Uzaklığı" = ? WHERE otel_ad = ?', (uzaklik_metni, otel_ad))
                                else:
                                    deger = deger if deger.strip() else "No Info"
                                    cursor.execute(f'UPDATE otel SET "{baslik}" = ? WHERE otel_ad = ?', (deger, otel_ad))

            # Otel Özellikleri başlığı altındaki verileri çekme
            for ozellik in [otel_ozellikleri, ucretsiz_aktiviteler, ucretli_aktiviteler, cocuk_aktiviteleri]:
                if ozellik:
                    otel_ozellikleri_listesi = ozellik.find('ul')
                    if otel_ozellikleri_listesi:
                        cursor.execute('PRAGMA table_info(otel)')
                        columns = cursor.fetchall()
                        column_names = [column[1] for column in columns]

                        for li in otel_ozellikleri_listesi.find_all('li'):
                            ozellik = li.text.strip()

                            adet = 1
                            
                            if '(' in ozellik:
                                adet_firstindex = ozellik.find('(')
                                adet_lastindex = ozellik.find(' Adet')
                                if adet_firstindex > 0:
                                    ozellik_adi = ozellik[:adet_firstindex].strip()
                                    if ozellik_adi in column_names:
                                        adet_str = ozellik[adet_firstindex+1:adet_lastindex].strip()
                                        adet = adet_str
                                        cursor.execute(f'UPDATE otel SET "{ozellik_adi}" = ? WHERE otel_ad = ?', (adet, otel_ad))
                            else: 
                                if ozellik in column_names:                                           
                                    cursor.execute(f'UPDATE otel SET "{ozellik}" = ? WHERE otel_ad = ?', (adet, otel_ad))

            # Değişiklikleri kaydetme
            conn.commit()
conn.close()

# WebDriver'ı kapatma
driver.quit()
