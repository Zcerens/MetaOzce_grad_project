# -*- coding: utf-8 -*-
"""
Created on Sun Mar 31 18:15:12 2024

@author: ZC
"""

import pandas as pd
from sklearn.metrics.pairwise import cosine_similarity

# Veri setini yükleme
data = pd.read_csv("duzenlenmis_otel_veritabani_DB3.csv")
data.dropna(inplace=True)

# Kullanıcının önceki gittiği otelin adını al
onceki_otel_ad = "Adam Eve"  # Örnek olarak

# Önceki otelin özelliklerini bulma
onceki_otel = data[data['otel_ad'] == onceki_otel_ad].drop(columns=['otel_ad', 'fiyat', 'il', 'ilce'])

# Veri setindeki diğer otellerin özelliklerini al
diget_oteller = data.drop(columns=['otel_ad', 'fiyat', 'il', 'ilce'])

# Cosine similarity kullanarak benzerlik ölçüsünü hesaplama
benzerlik_skorlari = cosine_similarity(onceki_otel, diget_oteller)

# En uygun otellerin indekslerini bulma (kendisini hariç tutarak)
en_uygun_otel_indeksleri = benzerlik_skorlari.flatten().argsort()[-4:-1]

# Önerilen otellerin adlarını bulma
onerilen_oteller_adlar = data.loc[en_uygun_otel_indeksleri, 'otel_ad']

print("Önerilen oteller: ")
for otel_ad in onerilen_oteller_adlar:
    print(otel_ad)
    




