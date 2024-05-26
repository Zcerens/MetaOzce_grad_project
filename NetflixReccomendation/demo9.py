import pandas as pd
from sklearn.metrics.pairwise import cosine_similarity
from sklearn.preprocessing import StandardScaler
from sklearn.pipeline import make_pipeline

# Film veri seti
films_data = {
    'film_adı': ['Film1', 'Film2', 'Film3', 'Film4', 'Film5'],
    'süre': [120, 90, 110, 100, 95],
    'kategori': ['romantik', 'fantastik', 'komedi', 'romantik', 'aksiyon'],
    'IMDb_puanı': [7.8, 6.5, 8.2, 7.0, 7.5],
    'yönetmen': ['Yönetmen1', 'Yönetmen2', 'Yönetmen3', 'Yönetmen4', 'Yönetmen5'],
    'oyuncular': [['Oyuncu1', 'Oyuncu2'], ['Oyuncu3', 'Oyuncu4'], ['Oyuncu5', 'Oyuncu6'], 
                  ['Oyuncu7', 'Oyuncu8'], ['Oyuncu9', 'Oyuncu10']],
    'yapım_yılı': [2005, 2010, 2015, 2020, 2018]
}

films_df = pd.DataFrame(films_data)

# Kullanıcı izleme geçmişi
user1_data = {
    'film_adı': ['Film1', 'Film2'],
    'puan': [4, 5],
    'tercihler': {'romantik': True, 'fantastik': False, 'komedi': True, 'aksiyon': False},
    'süre_tercihi': 'uzun',
    'IMDb_tercihi': 'yüksek'
}

user2_data = {
    'film_adı': ['Film3', 'Film5'],
    'puan': [4, 3],
    'tercihler': {'romantik': False, 'fantastik': True, 'komedi': False, 'aksiyon': True},
    'süre_tercihi': 'kısa',
    'IMDb_tercihi': 'orta'
}

user3_data = {
    'film_adı': ['Film2', 'Film4'],
    'puan': [3, 4],
    'tercihler': {'romantik': True, 'fantastik': False, 'komedi': True, 'aksiyon': False},
    'süre_tercihi': 'orta',
    'IMDb_tercihi': 'yüksek'
}

user4_data = {
    'film_adı': ['Film1', 'Film3'],
    'puan': [5, 4],
    'tercihler': {'romantik': True, 'fantastik': False, 'komedi': False, 'aksiyon': True},
    'süre_tercihi': 'uzun',
    'IMDb_tercihi': 'yüksek'
}

users_data = [user1_data, user2_data, user3_data, user4_data]

# Kullanıcı izleme geçmişini oluşturma
user_movie_matrix = pd.DataFrame(index=['Kullanıcı1', 'Kullanıcı2', 'Kullanıcı3', 'Kullanıcı4'], columns=films_df['film_adı'])
for i, user_data in enumerate(users_data, start=1):
    for film_adı, puan in zip(user_data['film_adı'], user_data['puan']):
        user_movie_matrix.loc[f'Kullanıcı{i}', film_adı] = puan
# Kosinüs benzerliği
cosine_sim = cosine_similarity(user_movie_matrix.fillna(0).T)
print("Cosine similarity matrix shape:", cosine_sim.shape)


# Film önerisi yapacak fonksiyon
def get_recommendations(user_id, user_movie_matrix, films_df, cosine_sim, num_recommendations=2):
    # Kullanıcının izleme geçmişini al
    user_ratings = user_movie_matrix.loc[f'Kullanıcı{user_id}']
    # Benzer kullanıcıların önerilerini bul
    similar_users = cosine_sim[user_id - 1].argsort()[:-num_recommendations-1:-1]

    # Benzer kullanıcı sayısı, cosine_sim boyutunu aşmamalı
    similar_users = similar_users[:min(num_recommendations, cosine_sim.shape[0])]


    print("Similar users:", similar_users)  # Hata izleme için eklendi
    print("Similar users size:", similar_users.size)  # Hata izleme için eklendi
    
    try:
        # Benzer kullanıcıların izleme geçmişini topla
        similar_users_movies = user_movie_matrix.iloc[similar_users].fillna(0)
    except IndexError as e:
        print("Index error occurred:", e)
        raise  # Hata anında durdurma
    
    # Ortalama kullanıcı izleme geçmişi
    mean_ratings = similar_users_movies.mean(axis=0)
    # İzleme geçmişi ve önerilen filmleri birleştir
    user_recommendations = pd.concat([user_ratings, mean_ratings], axis=1, keys=['puan', 'ortalama_puan'])
    # İzlenmemiş filmleri seç
    user_recommendations = user_recommendations[user_recommendations['puan'].isna()]
    if user_recommendations.empty:
        return pd.DataFrame(columns=['puan', 'ortalama_puan']) # Eğer öneri yapılacak film yoksa boş DataFrame döndür
    
    # Benzer kullanıcı sayısı, öneri yapılacak film sayısından azsa, öneri sayısını buna göre ayarla
    actual_recommendations = min(num_recommendations, len(similar_users))
    
    # Ortalama puana göre sırala ve öneri yap
    recommendations = user_recommendations.sort_values(by='ortalama_puan', ascending=False).head(actual_recommendations)
    return recommendations

# Öneri yapılacak her bir kullanıcı için önerileri al
for user_id in range(1, 5):
    recommendations = get_recommendations(user_id, user_movie_matrix, films_df, cosine_sim)
    print(f"\nKullanıcı{user_id}'ye Öneriler:")
    print(recommendations)
