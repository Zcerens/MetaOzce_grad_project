# -*- coding: utf-8 -*-
"""
Created on Sun Mar 31 18:39:47 2024

regresyon yetmıyor farklı mkaıne ogrenmesı methodları ıle yapaba
@author: ZC
"""

import pandas as pd
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics.pairwise import cosine_similarity

# Veri kümesini yükleyin
data = pd.read_csv("hotelDB_with_price_DB3.csv")

# Özellikler (X) ve hedef değişken (y) tanımlama
features = ['Açık Havuz', 'Kapalı Havuz', 'A la Carte Restoran', 'Asansör', 'Açık Restoran', 'Kapalı Restoran', 'Bedensel Engelli Odası', 'Bar', 'Su Kaydırağı', 'Balo Salonu', 'Kuaför', 'Otopark', 'Market', 'Sauna', 'Doktor', 'Beach Voley', 'Fitness', 'Canlı Eğlence', 'Wireless Internet', 'Animasyon', 'Sörf', 'Paraşüt', 'Araç Kiralama', 'Kano', 'SPA', 'Masaj', 'Masa Tenisi', 'Çocuk Havuzu', 'Çocuk Parkı']

X = data[features]
y = data['Fiyat Aralığı']

# Modeli eğitin
model = RandomForestClassifier(random_state=42)
model.fit(X, y)

# Özellik önem sırasını alın
feature_importance = model.feature_importances_

# Özellikleri önem sırasına göre sıralama
sorted_features = [f for _, f in sorted(zip(feature_importance, features), reverse=True)]

# Veri setini yükleme
data = pd.read_csv("duzenlenmis_otel_veritabani_DB3.csv")
data.dropna(inplace=True)

# Kullanıcının önceki gittiği otelin adını al
onceki_otel_ad = "Adam Eve"  # Örnek olarak

# Önceki otelin özelliklerini bulma
onceki_otel = data[data['otel_ad'] == onceki_otel_ad].drop(columns=['otel_ad', 'Fiyat Aralığı', 'il', 'ilce'])

# Veri setindeki diğer otellerin özelliklerini al
diget_oteller = data.drop(columns=['otel_ad', 'Fiyat Aralığ', 'il', 'ilce'])

# Özellikleri önem sırasına göre yeniden sıralama
diget_oteller = diget_oteller[sorted_features]

# Cosine similarity kullanarak benzerlik ölçüsünü hesaplama
benzerlik_skorlari = cosine_similarity(onceki_otel, diget_oteller)

# En uygun otelin indeksini bulma (kendisini hariç tutarak)
en_uygun_otel_indeksi = benzerlik_skorlari.flatten().argsort()[-4:-1]

# Önerilen otellerin adlarını bulma
onerilen_oteller_adlar = data.loc[en_uygun_otel_indeksi, 'otel_ad']

print("Önerilen oteller: ")
for otel_ad in onerilen_oteller_adlar:
    print(otel_ad)
