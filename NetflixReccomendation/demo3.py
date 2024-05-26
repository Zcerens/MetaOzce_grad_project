import pandas as pd

# Kullanıcı-film ilişkisini gösteren tarih veri seti
data = {
    'userId': [1, 1, 2, 2, 3, 3, 4, 4],
    'movieId': [1, 2, 2, 3, 4, 5, 5, 6],
    'rating': [5, 4, 4, 3, 2, 1, 3, 2]
}

# Tarih veri setini oluştur
historical_data = pd.DataFrame(data)

print("Tarih Veri Seti:")
print(historical_data)

# Kullanıcı-film matrisini oluştur
user_movie_matrix = historical_data.pivot_table(index='userId', columns='movieId', values='rating', fill_value=0)

print("\nKullanıcı-Film Matrisi:")
print(user_movie_matrix)

# Her bir kullanıcı için film önerileri yap
def recommend_movies_for_user(user_id, user_movie_matrix, movie_data, num_recommendations=2):
    user_ratings = user_movie_matrix.loc[user_id]
    already_watched = user_ratings[user_ratings > 0].index.tolist()
    movie_scores = user_movie_matrix.drop(already_watched, axis=1).mean(axis=0)
    
    # Kullanıcının tercih ettiği türleri al
    preferred_genres = movie_data[movie_data['movieId'].isin(already_watched)]['genres'].str.split('|').explode().value_counts().index.tolist()
    
    # Kullanıcının tercih ettiği türleri öne çıkar
    top_recommendations = movie_scores.sort_values(ascending=False)
    for genre in preferred_genres:
        top_recommendations = top_recommendations[~top_recommendations.index.isin(movie_data[movie_data['genres'].str.contains(genre)]['movieId'])]
    
    top_recommendations = top_recommendations.head(num_recommendations)
    return top_recommendations

# Örnek kullanım
movie_data = pd.read_csv('movies.csv')
for user_id in range(1, 5):
    recommendations = recommend_movies_for_user(user_id, user_movie_matrix, movie_data)
    print(f"\nKullanıcı {user_id} için Önerilen Filmler:")
    print(recommendations)
