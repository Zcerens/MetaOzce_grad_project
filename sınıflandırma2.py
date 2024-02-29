# -*- coding: utf-8 -*-
"""
Created on Mon Feb 26 14:09:38 2024

@author: usnis
"""

import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestRegressor, AdaBoostRegressor
from sklearn.linear_model import Lasso
from sklearn.preprocessing import MinMaxScaler
from sklearn.metrics import mean_squared_error

# Veriyi okuma

data_train = pd.read_csv('HotelDB2.csv')
data_test = pd.read_csv('HotelDB2.csv')
columns_to_convert = ['Bölge', 'Hava Alanına Uzaklığı', 'Denize Uzaklığı', 'Plaj', 'İskele']
for column in columns_to_convert:
    data_train[column] = data_train[column].apply(lambda x: 0 if x == 'yok' else 1)

X_train, y_train = data_train.drop('A la Carte Restoran', axis=1), data_train['A la Carte Restoran']
X_test, y_test = data_test.drop('A la Carte Restoran', axis=1), data_test['A la Carte Restoran']


scaler = MinMaxScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.transform(X_test)

#Random Forest
reg_RF = RandomForestRegressor(n_estimators=100, random_state=0)
reg_RF.fit(X_train_scaled, y_train)
rf_train_mse = mean_squared_error(np.log(y_train), np.log(reg_RF.predict(X_train_scaled)), squared=True)
rf_test_mse = mean_squared_error(np.log(y_test), np.log(reg_RF.predict(X_test_scaled)), squared=True)
print("Random Forest Regressor Train Performance:", rf_train_mse)
print("Random Forest Regressor Test Performance:", rf_test_mse)

# AdaBoost Regresyon Modeli
reg_ABR = AdaBoostRegressor(n_estimators=100, random_state=0)
reg_ABR.fit(X_train_scaled, y_train)
abr_train_mse = mean_squared_error(np.log(y_train), np.log(reg_ABR.predict(X_train_scaled)), squared=True)
abr_test_mse = mean_squared_error(np.log(y_test), np.log(reg_ABR.predict(X_test_scaled)), squared=True)
print("AdaBoost Regressor Train Performance:", abr_train_mse)
print("AdaBoost Regressor Test Performance:", abr_test_mse)

# Lasso Regresyon Modeli
lasso = Lasso()
lasso.fit(X_train_scaled, y_train)
lasso_train_mse = mean_squared_error(np.log(y_train), np.log(lasso.predict(X_train_scaled)), squared=True)
lasso_test_mse = mean_squared_error(np.log(y_test), np.log(lasso.predict(X_test_scaled)), squared=True)
print("Lasso Train Performance:", lasso_train_mse)
print("Lasso Test Performance:", lasso_test_mse)