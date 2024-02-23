# -*- coding: utf-8 -*-
"""
Created on Fri Feb 23 10:45:39 2024

@author: ZC
"""

import pandas as pd
from sklearn.ensemble import RandomForestClassifier

# Veri tabanınızı kullanarak bir DataFrame oluşturun
data = pd.read_csv("hotelDB2.csv")

df = pd.DataFrame(data)


# Modeli eğitin
features = ['Açık Havuz', 'A la Carte Restoran', 'Sauna', 'Çocuk Parkı']
X = df[features]
y = df['Plaj']  # Plaj sütunu, modelin eğitildiği sırada kullanılmasa da eklenmiştir.

model = RandomForestClassifier(random_state=42)
model.fit(X, y)

# Kullanıcı tercih ettiği özellikleri belirleyin
kullanici_tercihleri = {'Açık Havuz': 1, 'A la Carte Restoran': 1, 'Sauna': 0, 'Çocuk Parkı': 0}

# Kullanıcının tercih ettiği özelliklere göre modeli kullanarak tahmin yapın
X_kullanici = pd.DataFrame([kullanici_tercihleri])

plaj_tahmin = model.predict(X_kullanici)



# Tahmin edilen sınıfa göre otelleri filtreleyin
uygun_oteller = df[df['Plaj'] == plaj_tahmin[0]]


# Uygun otelleri listeleyin
print("Kullanıcının tercih ettiği özelliklere uygun oteller:")
print(uygun_oteller[['otel_ad', 'Plaj','Açık Havuz', 'A la Carte Restoran', 'Sauna', 'Çocuk Parkı']])
