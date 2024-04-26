import pandas as pd

# Veri tabanını oku
data = pd.read_csv("hotelDB_with_price_DB3.csv")



# Fiyat sütununu düzelt
data['fiyat'] = data['fiyat'].apply(lambda x: float(x.replace('.', '').replace(',', '.')[:-4]))


# Fiyat aralığı sütununu düzenle: "+" işaretini kaldır
data['Fiyat Aralığı'] = data['Fiyat Aralığı'].str.replace('+', '')

# Bölge sütununu düzenle: İl ve ilçe ayrı sütunlara böl
data[['il', 'ilce']] = data['Bölge'].str.split('-', n=1, expand=True)


# Hava Alanına Uzaklık ve Denize Uzaklık sütunlarını düzenle: "km" işaretini kaldır
# Hava Alanına Uzaklık sütununu düzenle
data['Hava Alanına Uzaklığı'] = data['Hava Alanına Uzaklığı'].str.extract('(\d+)').fillna(0).astype(int)


# Denize Uzaklık sütununu düzenle
def process_denize_uzaklik(deger):
    if deger == 'Denize Sıfır':
        return 0
    elif 'Arası' in deger:
        return int(deger.split()[0])  # Arası ifadesinin başındaki sayıyı al
    elif 've Üzeri' in deger:
        return int(deger.split()[0])  # "ve Üzeri" ifadesinin başındaki sayıyı al
    elif deger.isdigit():
        return int(deger)
    else:
        return None

# Denize Uzaklık sütununu düzenle
data['Denize Uzaklığı'] = data['Denize Uzaklığı'].apply(process_denize_uzaklik)

# Plaj sütununu düzenle: "Var" ve "Yok" değerlerini 1 ve 0'a dönüştür
data['Plaj'] = data['Plaj'].map({'Var': 1, 'Yok': 0})

# İskele sütununu düzenle: "Var" ve "Yok" değerlerini 1 ve 0'a dönüştür
data['İskele'] = data['İskele'].map({'Var': 1, 'Yok': 0})

# Diğer özellik sütunlarını düzenle: "+" işaretini kaldır
features = ['A la Carte Restoran', 'Asansör', 'Açık Restoran', 'Kapalı Restoran', 'Açık Havuz', 'Kapalı Havuz', 
            'Bedensel Engelli Odası', 'Bar', 'Su Kaydırağı', 'Balo Salonu', 'Kuaför', 'Otopark', 'Market', 'Sauna', 
            'Doktor', 'Beach Voley', 'Fitness', 'Canlı Eğlence', 'Wireless Internet', 'Animasyon', 'Sörf', 'Paraşüt', 
            'Araç Kiralama', 'Kano', 'SPA', 'Masaj', 'Masa Tenisi', 'Çocuk Havuzu', 'Çocuk Parkı']
data[features] = data[features].replace({'+': 1})

# Son olarak gereksiz sütunları kaldırın
data.drop(['Bölge', 'Fiyat Aralığı','Plaj'], axis=1, inplace=True)

# Düzenlenmiş veriyi kaydedin
data.to_csv("duzenlenmis_otel_veritabani_DB3.csv", index=False)

# Sadece Antalya ili olan verileri seç
antalya_data = data[data['il'] == 'Antalya ']

# Seçilen verileri "antalya_veritabani.csv" adında yeni bir CSV dosyasına kaydet
antalya_data.to_csv("antalya_veritabani.csv", index=False)