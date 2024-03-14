import pandas as pd
from sklearn.linear_model import LinearRegression

# CSV dosyasından verileri okuyun
df = pd.read_csv("antalya_veritabani.csv")

# Eksik değerlere sahip gözlemleri veri setinden çıkarın
df.dropna(inplace=True)


kullanici_tercihleri = {'Kano':0}


# Kullanıcının tercih ettiği özelliklerdeki otelleri filtreleyin
filtreli_df = df.copy()
for ozellik, deger in kullanici_tercihleri.items():
    filtreli_df = filtreli_df[filtreli_df[ozellik] == deger]

# Bağımsız değişkenler ve bağımlı değişkenleri belirleyin
X = filtreli_df.drop(['otel_ad', 'fiyat', 'il', 'ilce'], axis=1) # Bağımsız değişkenler
y = filtreli_df['fiyat'] # Bağımlı değişken

# Eğer filtrelenmiş veri kümesi boşsa, hata mesajı verin
if len(X) == 0:
    print("Belirttiğiniz tercihlere uygun otel bulunamadı.")
else:
    # Doğrusal regresyon modelini eğitin
    model = LinearRegression()
    model.fit(X, y)

    # Kullanıcının tercih ettiği özelliklerdeki otelin fiyatını tahmin edin
    kullanicinin_verisi = []
    for ozellik in X.columns:
        if ozellik in kullanici_tercihleri:
            kullanicinin_verisi.append(kullanici_tercihleri[ozellik])
        else:
            kullanicinin_verisi.append(0)  # Kullanıcı bu özelliği belirtmediyse, varsayılan olarak 0 ata

    tahmin_edilen_fiyat = model.predict([kullanicinin_verisi])

    print("Tahmin Edilen Fiyat:", tahmin_edilen_fiyat[0])
