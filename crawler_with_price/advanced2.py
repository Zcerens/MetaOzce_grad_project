import pandas as pd
from sklearn.ensemble import RandomForestClassifier
import matplotlib.pyplot as plt

# Veri tabanınızı kullanarak bir DataFrame oluşturun
data = pd.read_csv("hotelDB_with_price.csv")
df = pd.DataFrame(data)

# Modeli eğitin
features = ['Açık Havuz', 'Kapalı Havuz', 'A la Carte Restoran', 'Asansör', 'Açık Restoran', 'Kapalı Restoran', 'Bedensel Engelli Odası', 'Bar', 'Su Kaydırağı', 'Balo Salonu', 'Kuaför', 'Otopark', 'Market', 'Sauna', 'Doktor', 'Beach Voley', 'Fitness', 'Canlı Eğlence', 'Wireless Internet', 'Animasyon', 'Sörf', 'Paraşüt', 'Araç Kiralama', 'Kano', 'SPA', 'Masaj', 'Masa Tenisi', 'Çocuk Havuzu', 'Çocuk Parkı']
X = df[features]
y = df['Fiyat Aralığı']

model = RandomForestClassifier(random_state=42)
model.fit(X, y)

# Özellik önem sırasını alın
feature_importance = model.feature_importances_

# Özelliklerle eşleştirilmiş önem sırasını bir DataFrame'e dönüştürün
feature_importance_df = pd.DataFrame({'Feature': features, 'Importance': feature_importance})

# Görselleştirme
plt.figure(figsize=(10, 6))
plt.bar(feature_importance_df['Feature'], feature_importance_df['Importance'])
plt.xlabel('Features')
plt.ylabel('Importance')
plt.title('Feature Importance')
plt.xticks(rotation=45)
plt.show()

# Kullanıcı tercih ettiği özellikleri belirleyin
kullanici_tercihleri = {'Açık Havuz': 1, 'Kapalı Havuz': 0, 'A la Carte Restoran': 1, 'Asansör': 1, 'Açık Restoran': 1, 'Kapalı Restoran': 0, 'Bedensel Engelli Odası': 0, 'Bar': 1, 'Su Kaydırağı': 0, 'Balo Salonu': 1, 'Kuaför': 0, 'Otopark': 1, 'Market': 0, 'Sauna': 1, 'Doktor': 0, 'Beach Voley': 0, 'Fitness': 1, 'Canlı Eğlence': 1, 'Wireless Internet': 1, 'Animasyon': 1, 'Sörf': 0, 'Paraşüt': 0, 'Araç Kiralama': 0, 'Kano': 0, 'SPA': 1, 'Masaj': 1, 'Masa Tenisi': 1, 'Çocuk Havuzu': 1, 'Çocuk Parkı': 1}

print("Kullanıcı Tercihleri: ", kullanici_tercihleri)

# Kullanıcının tercih ettiği özelliklere göre modeli kullanarak fiyat tahmini yapın
X_kullanici = pd.DataFrame([kullanici_tercihleri])
fiyat_tahmini_kullanici = model.predict(X_kullanici)[0]
print("Kullanıcının tercihlerine göre tahmin edilen fiyat aralığı:", fiyat_tahmini_kullanici)

# Tahmin edilen fiyat aralığını işleyin
fiyat_araligi = fiyat_tahmini_kullanici
if '-' in fiyat_araligi:
    min_fiyat, max_fiyat = map(int, fiyat_araligi.split('-'))
    tahmin_edilen_fiyat = (min_fiyat + max_fiyat) / 2
else:
    tahmin_edilen_fiyat = float(fiyat_araligi)

# Görselleştirme
plt.figure(figsize=(10, 6))
plt.bar(feature_importance_df['Feature'], feature_importance_df['Importance'])
plt.xlabel('Features')
plt.ylabel('Importance')
plt.title('Feature Importance')
plt.xticks(rotation=45)
plt.axhline(y=0.02, color='r', linestyle='--')  # Önemli eşik değeri
plt.show()

# Özellik önem sırasını azalan şekilde sıralayın
feature_importance_df = feature_importance_df.sort_values(by='Importance', ascending=False)

print("\n***********************************************")
print("Özelliklerin Önem Sırası:")
print(feature_importance_df)

# Tahmin edilen fiyat ile gerçek fiyatı karşılaştırın
gercek_fiyatlar = df[df['Fiyat Aralığı'] == fiyat_tahmini_kullanici]['fiyat'].apply(lambda x: float(x.replace('.', '').replace(',', '.')[:-4]))

# Tahmin edilen fiyat ile gerçek fiyatlar arasındaki farkı hesaplayın
fiyat_farki = gercek_fiyatlar - tahmin_edilen_fiyat

# Sonucu yazdırın
print("\n***********************************************")
print("Gerçek Fiyatlar vs Tahmin Edilen Fiyatlar ve Farkları:")
for index, (gercek_fiyat, fark) in enumerate(zip(gercek_fiyatlar, fiyat_farki)):
    print("Otel", index+1, ": Gerçek Fiyat:", gercek_fiyat, "TL - Tahmin Edilen Fiyat:", tahmin_edilen_fiyat, "TL - Fark:", fark, "TL")
