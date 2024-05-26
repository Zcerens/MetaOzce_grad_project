import csv

# movies.csv dosyasını oluştur
movies_data = [
    {'movieId': 1, 'title': 'Toy Story (1995)', 'genres': 'Adventure|Animation|Children|Comedy|Fantasy'},
    {'movieId': 2, 'title': 'Jumanji (1995)', 'genres': 'Adventure|Children|Fantasy'},
    {'movieId': 3, 'title': 'Grumpier Old Men (1995)', 'genres': 'Comedy|Romance'},
    {'movieId': 4, 'title': 'Waiting to Exhale (1995)', 'genres': 'Comedy|Drama|Romance'},
    {'movieId': 5, 'title': 'Father of the Bride Part II (1995)', 'genres': 'Comedy'}
]

with open('movies.csv', 'w', newline='') as csvfile:
    fieldnames = ['movieId', 'title', 'genres']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

    writer.writeheader()
    for movie in movies_data:
        writer.writerow(movie)

# ratings.csv dosyasını oluştur
ratings_data = [
    {'userId': 1, 'movieId': 1, 'rating': 4.0, 'timestamp': 964982703},
    {'userId': 1, 'movieId': 3, 'rating': 4.0, 'timestamp': 964981247},
    {'userId': 1, 'movieId': 6, 'rating': 4.0, 'timestamp': 964982224},
    {'userId': 1, 'movieId': 47, 'rating': 5.0, 'timestamp': 964983815},
    {'userId': 1, 'movieId': 50, 'rating': 5.0, 'timestamp': 964982931},
    {'userId': 2, 'movieId': 1, 'rating': 3.5, 'timestamp': 964981780},
    {'userId': 2, 'movieId': 4, 'rating': 3.0, 'timestamp': 964982703},
    {'userId': 2, 'movieId': 7, 'rating': 3.5, 'timestamp': 964981247},
    {'userId': 2, 'movieId': 47, 'rating': 4.0, 'timestamp': 964982224},
    {'userId': 2, 'movieId': 50, 'rating': 4.5, 'timestamp': 964983815}
]

with open('ratings.csv', 'w', newline='') as csvfile:
    fieldnames = ['userId', 'movieId', 'rating', 'timestamp']
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

    writer.writeheader()
    for rating in ratings_data:
        writer.writerow(rating)
