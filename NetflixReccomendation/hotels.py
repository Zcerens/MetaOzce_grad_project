import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.pipeline import Pipeline
from sklearn.compose import ColumnTransformer
from sklearn.preprocessing import FunctionTransformer
import numpy as np

# Oteller ve kullanıcılar verilerini yükle
hotels_df = pd.read_csv("oteller.csv")
users_df = pd.read_csv("kullanıcılar.csv")

# TF-IDF vektörlerini oluşturmak için bir vektörleştirici oluştur
vectorizer = TfidfVectorizer(stop_words='english')

# Kullanıcılar ve oteller arasındaki ilişkiyi belirlemek için bir özellik vektörü oluştur
X_hotels = vectorizer.fit_transform(hotels_df['features'])
y_hotels = hotels_df['hotel_name']

# Kullanıcıların konakladığı otelleri belirleyen bir özellik vektörü oluştur
X_users = vectorizer.transform(users_df['hotel_features'])

# Modeli eğitmek için veri setini ayır
X_train, X_test, y_train, y_test = train_test_split(X_hotels, y_hotels, test_size=0.2, random_state=42)

# Random Forest sınıflandırıcısı oluştur
classifier = RandomForestClassifier(n_estimators=100, random_state=42)

# Pipeline oluştur
pipeline = Pipeline([
    ('classifier', classifier)
])

# Modeli eğit
pipeline.fit(X_train, y_train)

# Modelin performansını değerlendir
accuracy = pipeline.score(X_test, y_test)
print("Model Accuracy:", accuracy)

# Kullanıcıların kaldığı otellere göre otel önerileri yap
user_recommendations = {}
for i, user_id in enumerate(users_df['user_id']):
    user_features = X_users[i]
    predictions = pipeline.predict_proba(user_features)
    top_indices = predictions.argsort()[-5:][::-1]  # En iyi 5 oteli seç
    user_recommendations[user_id] = y_hotels[top_indices]

# Önerileri yazdır
for user_id, recommendations in user_recommendations.items():
    print(f"Kullanıcı {user_id} için Önerilen Oteller:")
    for recommendation in recommendations:
        print(recommendation)
    print()
