import pandas as pd
from sklearn.metrics.pairwise import cosine_similarity
from sklearn.preprocessing import MinMaxScaler

# Film özelliklerini içeren CSV dosyası
films_data = {
    'film_adı': [f'Film{i}' for i in range(1, 31)],
    'film_dakikası': [i * 10 for i in range(1, 31)],
    'film_kategorisi': ['Romantik' if i % 3 == 0 else 'Fantastik' if i % 2 == 0 else 'Komedi' for i in range(1, 31)]
}
films_df = pd.DataFrame(films_data)

# Kullanıcı verilerini içeren CSV dosyası
users_data = {
    'kullanıcı': ['Kullanıcı1', 'Kullanıcı1', 'Kullanıcı2', 'Kullanıcı2', 'Kullanıcı3', 'Kullanıcı3', 'Kullanıcı4', 'Kullanıcı4'],
    'film_adı': [f'Film{i}' for i in range(1, 9)],
    'puan': [5, 4, 4, 3, 2, 1, 3, 2]
}
users_df = pd.DataFrame(users_data)

# Kullanıcı ve film verilerini birleştirme
combined_df = pd.merge(users_df, films_df, on='film_adı')

# Kullanıcı-film tablosunu oluşturma
user_movie_matrix = combined_df.pivot_table(index='kullanıcı', columns='film_adı', values='puan').fillna(0)

# Benzerlik matrisini hesaplama
user_similarity = cosine_similarity(user_movie_matrix)

# Normalizasyon
scaler = MinMaxScaler()
normalized_similarity = scaler.fit_transform(user_similarity)

# Önerileri yapma
def recommend_movies_for_user(user_id, user_movie_matrix, films_df, num_recommendations=2):
    similar_users = normalized_similarity[user_id - 1].argsort()[::-1][1:]
    recommendations = []
    watched_movies = user_movie_matrix.loc[f'Kullanıcı{user_id}'][user_movie_matrix.loc[f'Kullanıcı{user_id}'] > 0].index
    
    for similar_user_id in similar_users:
        similar_user_movies = user_movie_matrix.iloc[similar_user_id]
        for movie in similar_user_movies.index:
            if movie not in watched_movies:
                recommendations.append((movie, similar_user_movies[movie]))
                if len(recommendations) >= num_recommendations:
                    break
        if len(recommendations) >= num_recommendations:
            break
    
    recommendations = pd.DataFrame(recommendations, columns=['film_adı', 'puan'])
    recommended_movies = pd.merge(recommendations, films_df, on='film_adı')
    return recommended_movies

# Kullanıcının izlediği filmleri, film sürelerini, kategorilerini ve verdikleri puanları yazdırma
def print_user_history(user_id, user_movie_matrix, films_df):
    user_history = user_movie_matrix.loc[f'Kullanıcı{user_id}'][user_movie_matrix.loc[f'Kullanıcı{user_id}'] > 0]
    user_history = user_history.reset_index()
    user_history = pd.merge(user_history, films_df, on='film_adı')
    print(f"\nKullanıcı{user_id}'nin İzleme Geçmişi:")
    print(user_history)

# Her bir kullanıcının izleme geçmişini yazdırma
for user_id in range(1, 5):
    print_user_history(user_id, user_movie_matrix, films_df)

# Önerileri al
for user_id in range(1, 5):
    recommendations = recommend_movies_for_user(user_id, user_movie_matrix, films_df)
    print(f"\nKullanıcı{user_id} için Önerilen Filmler:")
    print(recommendations)
