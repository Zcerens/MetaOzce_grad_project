import pandas as pd
from surprise import Dataset, Reader, SVD
from surprise.model_selection import train_test_split

# Film veri setini yükle
movies = pd.read_csv('movies.csv')
ratings = pd.read_csv('ratings.csv')

# Surprise için gerekli formatı oluştur
reader = Reader(rating_scale=(0.5, 5))
data = Dataset.load_from_df(ratings[['userId', 'movieId', 'rating']], reader)

# Veri setini eğitim ve test setlerine ayır
trainset, testset = train_test_split(data, test_size=0.2)

# SVD modelini eğit
model = SVD()
model.fit(trainset)

# Öneri yapacak fonksiyon
def get_recommendations(user_id, movies, model, n=5):
    # Kullanıcının izlemediği filmleri belirle
    watched_movies = ratings[ratings['userId'] == user_id]['movieId']
    all_movies = movies['movieId']
    to_predict = list(set(all_movies) - set(watched_movies))

    # Her bir film için tahmin yap
    predictions = [model.predict(user_id, movie_id) for movie_id in to_predict]

    # Tahminleri puan sırasına göre sırala
    predictions.sort(key=lambda x: x.est, reverse=True)

    # En iyi n filmi seç
    top_predictions = predictions[:n]

    # Önerilen filmlerin isimlerini döndür
    recommended_movies = [movies[movies['movieId'] == pred.i]['title'].values[0] for pred in top_predictions]

    return recommended_movies

# Örnek kullanım
user_id = 1
recommendations = get_recommendations(user_id, movies, model)
print(f"Kullanıcı{user_id}'ye Öneriler:")
for i, movie in enumerate(recommendations, start=1):
    print(f"{i}. {movie}")
