import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression

from sklearn.metrics import mean_squared_error

# CSV dosyasından verileri okuyun
df = pd.read_csv("duzenlenmis_otel_veritabani_DB3.csv")

# Eksik değerlere sahip gözlemleri veri setinden çıkarın
df.dropna(inplace=True)

# Eğitim ve test setlerini oluşturun
X = df.drop(['otel_ad', 'fiyat', 'il', 'ilce'], axis=1) # Bağımsız değişkenler
y = df['fiyat'] # Bağımlı değişken

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Doğrusal regresyon modelini eğitin
model = LinearRegression()
model.fit(X_train, y_train)

# Eğitim ve test setleri üzerinde tahmin yapın
y_train_pred = model.predict(X_train)
y_test_pred = model.predict(X_test)

# Hata metriklerini hesaplayın
train_rmse = mean_squared_error(y_train, y_train_pred, squared=False)
test_rmse = mean_squared_error(y_test, y_test_pred, squared=False)

print("Eğitim seti RMSE:", train_rmse)
print("Test seti RMSE:", test_rmse)

# Katsayıları ve kesme terimini yazdırın
print("Katsayılar:", model.coef_)
print("Kesme terimi:", model.intercept_)
