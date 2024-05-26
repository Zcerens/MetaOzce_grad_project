import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import linear_kernel

# Veri setini yükle
movies = pd.read_csv('movies.csv')
ratings = pd.read_csv('ratings.csv')

# Veri setlerini birleştir
df = pd.merge(movies, ratings, on='movieId')

# Pivot tablo oluştur
movie_matrix = df.pivot_table(index='title', columns='userId', values='rating').fillna(0)

# Cosine similarity kullanarak benzerlik matrisini hesapla
cosine_sim = linear_kernel(movie_matrix, movie_matrix)

# Benzerlik matrisini DataFrame'e dönüştür
cosine_sim_df = pd.DataFrame(cosine_sim, index=movie_matrix.index, columns=movie_matrix.index)

# Benzerlik matrisinin bir kısmını yazdır
print("Benzerlik Matrisinin Bir Kısmı:")
print(cosine_sim_df.head())

# Film önerileri fonksiyonu
def get_recommendations(title, cosine_sim=cosine_sim):
    idx = movies[movies['title'] == title].index[0]
    sim_scores = list(enumerate(cosine_sim[idx]))
    sim_scores = sorted(sim_scores, key=lambda x: x[1], reverse=True)
    sim_scores = sim_scores[1:11]
    movie_indices = [i[0] for i in sim_scores]
    return movies['title'].iloc[movie_indices]

# Örnek kullanım
movie_title = 'Toy Story (1995)'
print(f"\n'{movie_title}' Filmine Benzer Filmler:")
print(get_recommendations(movie_title))
