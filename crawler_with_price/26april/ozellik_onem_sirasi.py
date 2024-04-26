# -*- coding: utf-8 -*-
"""
Created on Fri Apr 26 19:37:33 2024

@author: ZC
"""

import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.svm import SVR
from sklearn.metrics import mean_squared_error

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

# Özelliklerin katsayılarını yazdırın
print("Özelliklerin Katsayıları:")
for i, feature in enumerate(X.columns):
    print(feature + ":", model.coef_[0][i])