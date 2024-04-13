import pandas as pd
from sklearn.neighbors import NearestNeighbors

# Veri tabanınızı kullanarak bir DataFrame oluşturun
data = pd.read_csv("hotelDB_with_price.csv")
df = pd.DataFrame(data)

# One-Hot Encoding
df = pd.get_dummies(df, columns=['Bölge'])
# 'Hava Alanına Uzaklığı' sütunundaki metinleri işleyerek sayısal değerlere dönüştürme
df['Hava Alanına Uzaklığı'] = df['Hava Alanına Uzaklığı'].str.extract('(\d+)').astype(float)
# 'Plaj' sütununu one-hot encoding ile dönüştürme
df = pd.get_dummies(df, columns=['Plaj'])
print(df['Hava Alanına Uzaklığı'])
print(df['Bölge'])


# Kullanıcının tercih ettiği özellikleri belirleyin
kullanici_tercihleri = {'Açık Havuz': 1, 'Kapalı Havuz': 0, 'A la Carte Restoran': 1, 'Asansör': 1, 'Açık Restoran': 1, 'Kapalı Restoran': 0, 'Bedensel Engelli Odası': 0, 'Bar': 1, 'Su Kaydırağı': 0, 'Balo Salonu': 1, 'Kuaför': 0, 'Otopark': 1, 'Market': 0, 'Sauna': 1, 'Doktor': 0, 'Beach Voley': 0, 'Fitness': 1, 'Canlı Eğlence': 1, 'Wireless Internet': 1, 'Animasyon': 1, 'Sörf': 0, 'Paraşüt': 0, 'Araç Kiralama': 0, 'Kano': 0, 'SPA': 1, 'Masaj': 1, 'Masa Tenisi': 1, 'Çocuk Havuzu': 1, 'Çocuk Parkı': 1}


# Modeli eğitim verisiyle eğitin
X = df.drop(columns=['otel_ad', 'fiyat', 'Fiyat Aralığı'])
nbrs = NearestNeighbors(n_neighbors=5, algorithm='auto').fit(X.values)

# Kullanıcı tercihlerine en yakın komşuları bulun
kullanici_tercihleri_array = pd.DataFrame(kullanici_tercihleri, index=[0])
_, indices = nbrs.kneighbors(kullanici_tercihleri_array)

# Bulunan komşuların fiyatlarını alın
komşu_fiyatlar = df.iloc[indices[0]]['fiyat'].apply(lambda x: float(x.replace('.', '').replace(',', '.')[:-4]))

# Tahmin edilen fiyatı komşu otellerin fiyatlarının ortalaması olarak hesaplayın
tahmin_edilen_fiyat = komşu_fiyatlar.mean()

print("Tahmin edilen fiyat:", tahmin_edilen_fiyat)

