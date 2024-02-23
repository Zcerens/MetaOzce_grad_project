import pandas as pd
from sklearn.ensemble import RandomForestClassifier

data = pd.read_csv("hotelDB2.csv")
df = pd.DataFrame(data)

# Modeli eğitimi
features = ['Açık Havuz', 'A la Carte Restoran', 'Sauna', 'Çocuk Parkı']
X = df[features]
y = df['Plaj']

model = RandomForestClassifier(random_state=42)
model.fit(X, y)

# Kullanıcı tercih 
kullanici_tercihleri = {'Açık Havuz': 1, 'A la Carte Restoran': 1, 'Sauna': 0, 'Çocuk Parkı': 0}

# tahmin
X_kullanici = pd.DataFrame([kullanici_tercihleri])
plaj_tahmin = model.predict(X_kullanici)

# filtreleme
filtre = (df['Açık Havuz'] == kullanici_tercihleri['Açık Havuz']) & \
         (df['A la Carte Restoran'] == kullanici_tercihleri['A la Carte Restoran']) & \
         (df['Sauna'] == kullanici_tercihleri['Sauna']) & \
         (df['Çocuk Parkı'] == kullanici_tercihleri['Çocuk Parkı'])

uygun_oteller = df[filtre & (model.predict(X) == plaj_tahmin[0])]


print("Kullanıcının tercih ettiği özelliklere uygun oteller:")
print(uygun_oteller[['otel_ad', 'Plaj', 'Açık Havuz', 'A la Carte Restoran', 'Sauna', 'Çocuk Parkı']])
