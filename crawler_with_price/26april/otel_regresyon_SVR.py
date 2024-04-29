# -*- coding: utf-8 -*-
"""
Created on Fri Apr 26 19:37:33 2024

@author: ZC
"""

import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.svm import SVR
from sklearn.metrics import mean_squared_error
import matplotlib.pyplot as plt


df = pd.read_csv("duzenlenmis_otel_veritabani_DB3.csv")


df.dropna(inplace=True)

# Eğitim ve test setleri
X = df.drop(['otel_ad', 'fiyat', 'il', 'ilce'], axis=1) # Bağımsız değişkenler
y = df['fiyat'] # Bağımlı değişken

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# SVR modelini
model = SVR(kernel='linear')  # Linear kernel kullanarak SVR modeli
model.fit(X_train, y_train)

# Eğitim ve test setleri üzerinde tahmin
y_train_pred = model.predict(X_train)
y_test_pred = model.predict(X_test)

# Hata metriklerini hesap
train_rmse = mean_squared_error(y_train, y_train_pred, squared=False)
test_rmse = mean_squared_error(y_test, y_test_pred, squared=False)

print("Eğitim seti RMSE:", train_rmse)
print("Test seti RMSE:", test_rmse)

# Özelliklerin katsayılarını yazdırın
print("Özelliklerin Katsayıları:")
for i, feature in enumerate(X.columns):
    print(feature + ":", model.coef_[0][i])
    

# Destek vektörlerinin katsayıları
coefficients = model.coef_[0]

# Özellik isimlerini alın
features = X.columns

# Özelliklerin destek vektörlerine katkısını gösteren bir plot
plt.figure(figsize=(16, 8))
plt.bar(features, coefficients, color='green')
plt.xlabel('Özellikler')
plt.ylabel('Destek Vektör Katsayıları')
plt.title('Özelliklerin Destek Vektörlerine Katkısı')
plt.xticks(rotation=80)
plt.grid(axis='y', linestyle='--', alpha=0.7)
plt.show()



# Step 1: Make Your Predictions
predicted_prices = model.predict(X)

# Round the predicted prices to one decimal place
predicted_prices_rounded = [round(abs(price), 1) * (-1 if price < 0 else 1) for price in predicted_prices]

# Step 2: Compare Predictions with Actual Prices and Add Hotel Names
price_comparison = pd.DataFrame({'Hotel Name': df['otel_ad'], 'Actual Price': y, 'Predicted Price': predicted_prices_rounded})

# Step 3: Analyze the Calculated Price Difference
price_comparison['Price Difference'] = price_comparison['Actual Price'] - price_comparison['Predicted Price']

# Round the price differences to one decimal place
price_comparison['Price Difference'] = [round(abs(diff), 1) * (-1 if diff < 0 else 1) for diff in price_comparison['Price Difference']]

# Step 4: Fine-Tuning
fair_price_threshold = 500  # Let's set a threshold, for example, 500 TL

# Determine fair price range
price_comparison['Fair Price Range'] = ''
price_comparison.loc[price_comparison['Price Difference'] > fair_price_threshold, 'Fair Price Range'] = 'Low'
price_comparison.loc[price_comparison['Price Difference'] < -fair_price_threshold, 'Fair Price Range'] = 'High'
price_comparison.loc[(price_comparison['Price Difference'] <= fair_price_threshold) & (price_comparison['Price Difference'] >= -fair_price_threshold), 'Fair Price Range'] = 'Medium'

# Display price comparison and fair price range
print(price_comparison)

# Write the data to a new CSV file
price_comparison.to_csv('price_comparison.csv', index=False)

