import pandas as pd
import matplotlib.pyplot as plt
from sklearn.ensemble import RandomForestClassifier

# Veri kümesini yükleyin
data = pd.read_csv("hotelDB_with_price.csv")

# Özellikler (X) ve hedef değişken (y) tanımlama
features = ['Açık Havuz', 'Kapalı Havuz', 'A la Carte Restoran', 'Asansör', 'Açık Restoran', 'Kapalı Restoran', 'Bedensel Engelli Odası', 'Bar', 'Su Kaydırağı', 'Balo Salonu', 'Kuaför', 'Otopark', 'Market', 'Sauna', 'Doktor', 'Beach Voley', 'Fitness', 'Canlı Eğlence', 'Wireless Internet', 'Animasyon', 'Sörf', 'Paraşüt', 'Araç Kiralama', 'Kano', 'SPA', 'Masaj', 'Masa Tenisi', 'Çocuk Havuzu', 'Çocuk Parkı']

X = data[features]
y = data['Fiyat Aralığı']


# Modeli eğitin
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
