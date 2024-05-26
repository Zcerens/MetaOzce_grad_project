import pandas as pd
from sklearn.metrics.pairwise import cosine_similarity

# Film veri seti
films_data = {
    'film_adı': ['Film1', 'Film2', 'Film3', 'Film4', 'Film5'],
    'süre': [120, 90, 110, 100, 95],
    'kategori': ['romantik', 'fantastik', 'komedi', 'romantik', 'aksiyon'],
    'IMDb_puanı': [7.8, 6.5, 8.2, 7.0, 7.5]
}

films_df = pd.DataFrame(films_data)

# Kullanıcı izleme geçmişi
user1_data = {
    'film_adı': ['Film1', 'Film2'],
    'puan': [4, 5]
}

user2_data = {
    'film_adı': ['Film3', 'Film5'],
    'puan': [4, 3]
}

user3_data = {
    'film_adı': ['Film2', 'Film4'],
    'puan': [3, 4]
}

user4_data = {
    'film_adı': ['Film1', 'Film3'],
    'puan': [5, 4]
}

users_data = [user1_data, user2_data, user3_data, user4_data]

# Kullanıcı izleme geçmişini oluşturma
user_movie_matrix = pd.DataFrame(index=['Kullanıcı1', 'Kullanıcı2', 'Kullanıcı3', 'Kullanıcı4'], columns=films_df['film_adı'])

for i, user_data in enumerate(users_data, start=1):
    for _, row in pd.DataFrame(user_data).iterrows():
        user_movie_matrix.loc[f'Kullanıcı{i}', row['film_adı']] = row['puan']

# Cosine similarity kullanarak benzerlik matrisini hesapla
cosine_sim = cosine_similarity(user_movie_matrix.fillna(0).infer_objects(copy=False))

# Film önerisi yapacak fonksiyon
def get_recommendations(user_id, user_movie_matrix, films_df, cosine_sim):
    # Kullanıcının izleme geçmişini al
    user_history = user_movie_matrix.loc[f'Kullanıcı{user_id}']
    # Tüm filmler arasındaki benzerlikleri al
    sim_scores = list(enumerate(cosine_sim[user_id - 1]))
    # Benzerlik skorlarına göre sırala
    sim_scores = sorted(sim_scores, key=lambda x: x[1], reverse=True)
    # En çok benzer olan 2 filmi al
    similar_indices = [i[0] for i in sim_scores[1:3]]
    # Önerilecek filmleri belirle
    recommended_movies = films_df.iloc[similar_indices]
    return recommended_movies

# Öneri yapılacak her bir kullanıcı için önerileri al
for user_id in range(1, 5):
    recommendations = get_recommendations(user_id, user_movie_matrix, films_df, cosine_sim)
    print(f"\nKullanıcı{user_id}'ye Öneriler:")
    print(recommendations)

# Kullanıcı tarihsel data setini de printle
for i, user_data in enumerate(users_data, start=1):
    print(f"\nKullanıcı{i} Tarihsel Verisi:")
    print(pd.DataFrame(user_data))
