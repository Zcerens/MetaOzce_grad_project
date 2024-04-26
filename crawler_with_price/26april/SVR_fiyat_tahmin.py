# -*- coding: utf-8 -*-
"""
Created on Fri Apr 26 19:57:34 2024

@author: ZC
"""


import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.svm import SVR
from sklearn.metrics import mean_squared_error
import matplotlib.pyplot as plt

# CSV dosyasından verileri okuyun
df = pd.read_csv("duzenlenmis_otel_veritabani_DB3.csv")

# Eksik değerlere sahip gözlemleri veri setinden çıkarın
df.dropna(inplace=True)

# Eğitim ve test setlerini oluşturun
X = df.drop(['otel_ad', 'fiyat', 'il', 'ilce'], axis=1) # Bağımsız değişkenler
y = df['fiyat'] # Bağımlı değişken

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# SVR modelini eğitin
model = SVR(kernel='linear')  # Linear kernel kullanarak SVR modeli
model.fit(X_train, y_train)

# Eğitim ve test setleri üzerinde tahmin yapın
y_train_pred = model.predict(X_train)
y_test_pred = model.predict(X_test)

# Hata metriklerini hesaplayın
train_rmse = mean_squared_error(y_train, y_train_pred, squared=False)
test_rmse = mean_squared_error(y_test, y_test_pred, squared=False)

print("Eğitim seti RMSE:", train_rmse)
print("Test seti RMSE:", test_rmse)

# Özelliklerin Katsayılarını Yazdırın
print("Özelliklerin Katsayıları:")
for i, feature in enumerate(X.columns):
    print(feature + ":", model.coef_[0][i])

# Adım 1: Tahminlerinizi Yapın
predicted_prices = model.predict(X)

# Adım 2: Tahminler ile Gerçek Fiyatları Karşılaştırın
price_comparison = pd.DataFrame({'Gerçek Fiyat': y, 'Tahmin Edilen Fiyat': predicted_prices})

# Adım 3: Hesaplanan Fiyat Farkını Analiz Edin
price_comparison['Fiyat Farkı'] = price_comparison['Gerçek Fiyat'] - price_comparison['Tahmin Edilen Fiyat']

# Adım 4: İnce Ayar Yapın
fair_price_threshold = 500  # Örnek olarak 500 TL'lik bir eşik belirleyelim

# Adil fiyat aralığını belirleme
price_comparison['Adil Fiyat Aralığı'] = ''
price_comparison.loc[price_comparison['Fiyat Farkı'] > fair_price_threshold, 'Adil Fiyat Aralığı'] = 'Düşük'
price_comparison.loc[price_comparison['Fiyat Farkı'] < -fair_price_threshold, 'Adil Fiyat Aralığı'] = 'Yüksek'
price_comparison.loc[(price_comparison['Fiyat Farkı'] <= fair_price_threshold) & (price_comparison['Fiyat Farkı'] >= -fair_price_threshold), 'Adil Fiyat Aralığı'] = 'Orta'

# Adım 5: Müşteri Geri Bildirimlerini Değerlendirin (Opsiyonel)
# Müşteri geri bildirimlerini almak için gerekli kodu ekleyebilirsiniz

# Fiyat karşılaştırmasını ve adil fiyat aralığını görüntüleme
print(price_comparison)

# Özelliklerin destek vektörlerine katkısını gösteren bir çubuk grafiği oluşturun
coefficients = model.coef_
features = X.columns

plt.figure(figsize=(24, 10))
plt.bar(features, coefficients, color='blue')
plt.xlabel('Özellikler')
plt.ylabel('Destek Vektör Katsayıları')
plt.title('Özelliklerin Destek Vektörlerine Katkısı')
plt.xticks(rotation=90)
plt.grid(axis='y', linestyle='--', alpha=0.7)
plt.show()


