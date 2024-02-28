import pandas as pd

# Film özelliklerini içeren CSV dosyası
films_data = {
    'film_adı': ['Film1', 'Film2', 'Film3', 'Film4', 'Film5', 'Film6', 'Film7', 'Film8', 'Film9', 'Film10', 'Film11', 'Film12', 'Film13', 'Film14', 'Film15', 'Film16'],
    'film_süresi': ['Kısa', 'Uzun', 'Kısa', 'Uzun', 'Kısa', 'Uzun', 'Kısa', 'Uzun', 'Kısa', 'Uzun', 'Kısa', 'Uzun', 'Kısa', 'Uzun', 'Kısa', 'Uzun'],
    'film_kategorisi': ['Romantik', 'Fantastik', 'Romantik', 'Komedi', 'Fantastik', 'Komedi', 'Romantik', 'Fantastik', 'Romantik', 'Komedi', 'Fantastik', 'Komedi', 'Romantik', 'Fantastik', 'Romantik', 'Komedi']
}
films_df = pd.DataFrame(films_data)

# Kullanıcı verilerini içeren CSV dosyası
users_data = {
    'kullanıcı': ['Kullanıcı1', 'Kullanıcı1', 'Kullanıcı2', 'Kullanıcı2', 'Kullanıcı3', 'Kullanıcı3', 'Kullanıcı4', 'Kullanıcı4'],
    'film_adı': ['Film1', 'Film3', 'Film2', 'Film4', 'Film5', 'Film6', 'Film8', 'Film10'],
    'puan': [5, 4, 4, 3, 2, 1, 3, 2],
    'film_süresi_tercihi': ['Kısa', 'Kısa', 'Uzun', 'Uzun', 'Kısa', 'Kısa', 'Uzun', 'Uzun']
}
users_df = pd.DataFrame(users_data)

# Kullanıcıların izlediği filmler ve puanları ile film özellikleri verilerini birleştir
merged_data = pd.merge(users_df, films_df, on='film_adı')

# Her bir kullanıcı için film önerileri yap
def recommend_movies_for_user(user_id, merged_data, num_recommendations=2):
    user_data = merged_data[merged_data['kullanıcı'] == f'Kullanıcı{user_id}']
    user_preferences = user_data['film_süresi_tercihi'].value_counts().idxmax()
    preferred_genre = user_data['film_kategorisi'].value_counts().idxmax()
    
    recommendations = films_df[films_df['film_süresi'] == user_preferences]
    recommendations = recommendations[recommendations['film_kategorisi'] == preferred_genre].head(num_recommendations)
    
    return recommendations

# Örnek kullanım
for user_id in range(1, 5):
    recommendations = recommend_movies_for_user(user_id, merged_data)
    print(f"\nKullanıcı{user_id} için Önerilen Filmler:")
    print(recommendations)
