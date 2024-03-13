# -*- coding: utf-8 -*-
"""
Created on Wed Mar 13 10:45:39 2024

@author: ZC
"""

import pandas as pd
from sklearn.ensemble import RandomForestClassifier

# Veri tabanınızı kullanarak bir DataFrame oluşturun
data = pd.read_csv("hotelDB_with_price.csv")

df = pd.DataFrame(data)


# Modeli eğitin
features = ['Açık Havuz','Kapalı Havuz', 'A la Carte Restoran', 'Sauna', 'Çocuk Parkı','Asansör']
X = df[features]
y = df['Fiyat Aralığı']  # Plaj sütunu, modelin eğitildiği sırada kullanılmasa da eklenmiştir.

model = RandomForestClassifier(random_state=42)
model.fit(X, y)

# Kullanıcı tercih ettiği özellikleri belirleyin
kullanici_tercihleri = {'Açık Havuz': 0, 'Kapalı Havuz':0,'A la Carte Restoran': 0, 'Sauna': 0, 'Çocuk Parkı': 1, 'Asansör' : 1}
print("Kullanıcı Tercihleri: ", kullanici_tercihleri)

# Kullanıcının tercih ettiği özelliklere göre modeli kullanarak tahmin yapın
X_kullanici = pd.DataFrame([kullanici_tercihleri])

fiyat_tahmin = model.predict(X_kullanici)



# Tahmin edilen sınıfa göre otelleri filtreleyin
uygun_oteller = df[df['Fiyat Aralığı'] == fiyat_tahmin[0]]
print("Tahmin edilen fiyat aralığı:", fiyat_tahmin[0])
# print("Veri setindeki fiyat aralıkları:", df['Fiyat Aralığı'].unique())




# Uygun otelleri listeleyin
print("\n***********************************************")
print("Kullanıcının tercih ettiği özelliklere uygun oteller:")
print(uygun_oteller[['otel_ad', 'Fiyat Aralığı','Açık Havuz','Kapalı Havuz', 'A la Carte Restoran', 'Sauna', 'Çocuk Parkı', 'Asansör']])