# -*- coding: utf-8 -*-
"""
Created on Wed Mar 13 10:45:39 2024

@author: ZC
"""

import pandas as pd
from sklearn.ensemble import RandomForestClassifier
import matplotlib.pyplot as plt

# Veri tabanınızı kullanarak bir DataFrame oluşturun
data = pd.read_csv("hotelDB_with_price.csv")

df = pd.DataFrame(data)


# Modeli eğitin
features = ['Açık Havuz', 'Kapalı Havuz', 'A la Carte Restoran', 'Asansör', 'Açık Restoran', 'Kapalı Restoran', 'Bedensel Engelli Odası', 'Bar', 'Su Kaydırağı', 'Balo Salonu', 'Kuaför', 'Otopark', 'Market', 'Sauna', 'Doktor', 'Beach Voley', 'Fitness', 'Canlı Eğlence', 'Wireless Internet', 'Animasyon', 'Sörf', 'Paraşüt', 'Araç Kiralama', 'Kano', 'SPA', 'Masaj', 'Masa Tenisi', 'Çocuk Havuzu', 'Çocuk Parkı']
print(features)
X = df[features]
y = df['Fiyat Aralığı']  

model = RandomForestClassifier(random_state=42)
model.fit(X, y)

# Özellik önem sırasını alın
feature_importance = model.feature_importances_

# Özelliklerle eşleştirilmiş önem sırasını bir DataFrame'e dönüştürün
feature_importance_df = pd.DataFrame({'Feature': features, 'Importance': feature_importance})

# Özellik önem sırasını azalan şekilde sıralayın
feature_importance_df = feature_importance_df.sort_values(by='Importance', ascending=False)

# Görselleştirme
plt.figure(figsize=(10, 6))
plt.bar(feature_importance_df['Feature'], feature_importance_df['Importance'])
plt.xlabel('Features')
plt.ylabel('Importance')
plt.title('Feature Importance')
plt.xticks(rotation=45)
plt.show()

# Kullanıcı tercih ettiği özellikleri belirleyin
kullanici_tercihleri = {'Açık Havuz': 1, 'Kapalı Havuz': 0, 'A la Carte Restoran':1 , 'Asansör': 1, 'Açık Restoran': 0, 'Kapalı Restoran': 0, 'Bedensel Engelli Odası': 1, 'Bar': 0, 'Su Kaydırağı': 0, 'Balo Salonu': 0, 'Kuaför': 0, 'Otopark': 0, 'Market': 0, 'Sauna': 0, 'Doktor': 0, 'Beach Voley': 0, 'Fitness': 0, 'Canlı Eğlence': 0, 'Wireless Internet': 0, 'Animasyon': 0, 'Sörf': 0, 'Paraşüt': 0, 'Araç Kiralama': 0, 'Kano': 0, 'SPA': 0, 'Masaj': 0, 'Masa Tenisi': 0, 'Çocuk Havuzu': 0, 'Çocuk Parkı': 0}

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
print(uygun_oteller[['otel_ad', 'fiyat','Fiyat Aralığı','Açık Havuz','Kapalı Havuz', 'A la Carte Restoran', 'Sauna', 'Çocuk Parkı', 'Asansör','Bedensel Engelli Odası']])

# Gerçek fiyatları alın ve düzgün bir formata dönüştürün
gercek_fiyatlar = uygun_oteller['fiyat'].apply(lambda x: float(x.replace('.', '').replace(',', '.')[:-4]))

# # Tahmin edilen fiyat aralığını işleyin
# fiyat_araligi = fiyat_tahmin[0]
# if '-' in fiyat_araligi:
#     min_fiyat, max_fiyat = map(int, fiyat_araligi.split('-'))
#     tahmin_edilen_fiyat = (min_fiyat + max_fiyat) / 2
# else:
#     tahmin_edilen_fiyat = float(fiyat_araligi)

# # Tahmin edilen fiyat ile gerçek fiyatlar arasındaki farkı hesaplayın
# fiyat_farki = gercek_fiyatlar - tahmin_edilen_fiyat

# # Sonucu yazdırın
# print("\n***********************************************")
# print("Gerçek Fiyatlar vs Tahmin Edilen Fiyatlar ve Farkları:")
# for index, (gercek_fiyat, fark) in enumerate(zip(gercek_fiyatlar, fiyat_farki)):
#     print("Otel", index+1, ": Gerçek Fiyat:", gercek_fiyat, "TL - Tahmin Edilen Fiyat:", tahmin_edilen_fiyat, "TL - Fark:", fark, "TL")
