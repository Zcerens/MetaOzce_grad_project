# -*- coding: utf-8 -*-
"""
Created on Sun Mar 31 17:49:54 2024

@author: ZC
"""

import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeRegressor
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_squared_error

# CSV dosyasından verileri okuyun
df = pd.read_csv("duzenlenmis_otel_veritabani_DB3.csv")

# Eksik değerlere sahip gözlemleri veri setinden çıkarın
df.dropna(inplace=True)

# Eğitim ve test setlerini oluşturun
X = df.drop(['otel_ad', 'fiyat', 'il', 'ilce'], axis=1) # Bağımsız değişkenler
y = df['fiyat'] # Bağımlı değişken

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Karar Ağacı Regresyonu
tree_model = DecisionTreeRegressor()
tree_model.fit(X_train, y_train)

# Orman Regresyonu
forest_model = RandomForestRegressor(n_estimators=100, random_state=42)
forest_model.fit(X_train, y_train)

# Karar Ağacı Regresyonu ile tahmin yapma
y_train_pred_tree = tree_model.predict(X_train)
y_test_pred_tree = tree_model.predict(X_test)

# Orman Regresyonu ile tahmin yapma
y_train_pred_forest = forest_model.predict(X_train)
y_test_pred_forest = forest_model.predict(X_test)

# Hata metriklerini hesaplayın
train_rmse_tree = mean_squared_error(y_train, y_train_pred_tree, squared=False)
test_rmse_tree = mean_squared_error(y_test, y_test_pred_tree, squared=False)

train_rmse_forest = mean_squared_error(y_train, y_train_pred_forest, squared=False)
test_rmse_forest = mean_squared_error(y_test, y_test_pred_forest, squared=False)

print("Karar Ağacı - Eğitim seti RMSE:", train_rmse_tree)
print("Karar Ağacı - Test seti RMSE:", test_rmse_tree)

print("Orman - Eğitim seti RMSE:", train_rmse_forest)
print("Orman - Test seti RMSE:", test_rmse_forest)
