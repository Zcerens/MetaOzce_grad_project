import psycopg2

# PostgreSQL veritabanına bağlanma
conn = psycopg2.connect(
    dbname="hotelDB",
    user="postgres",
    password="postgres",
    host="localhost",
    port="5432"
)
cursor = conn.cursor()

# Her bir sütun için sırayla RENAME COLUMN ifadelerini çalıştırma
rename_queries = [
    'ALTER TABLE otel RENAME COLUMN "Fiyat Aralığı" TO fiyat_araligi',
    'ALTER TABLE otel RENAME COLUMN "Bölge" TO bolge',
    'ALTER TABLE otel RENAME COLUMN "Hava Alanına Uzaklığı" TO hava_alanina_uzakligi',
    'ALTER TABLE otel RENAME COLUMN "Denize Uzaklığı" TO denize_uzakligi',
    'ALTER TABLE otel RENAME COLUMN "Plaj" TO plaj',
    'ALTER TABLE otel RENAME COLUMN "İskele" TO iskele',
    'ALTER TABLE otel RENAME COLUMN "A la Carte Restoran" TO a_la_carte_restoran',
    'ALTER TABLE otel RENAME COLUMN "Asansör" TO asansor',
    'ALTER TABLE otel RENAME COLUMN "Açık Restoran" TO acik_restoran',
    'ALTER TABLE otel RENAME COLUMN "Kapalı Restoran" TO kapali_restoran',
    'ALTER TABLE otel RENAME COLUMN "Açık Havuz" TO acik_havuz',
    'ALTER TABLE otel RENAME COLUMN "Kapalı Havuz" TO kapali_havuz',
    'ALTER TABLE otel RENAME COLUMN "Bedensel Engelli Odası" TO bedensel_engelli_odasi',
    'ALTER TABLE otel RENAME COLUMN "Bar" TO bar',
    'ALTER TABLE otel RENAME COLUMN "Su Kaydırağı" TO su_kaydiragi',
    'ALTER TABLE otel RENAME COLUMN "Balo Salonu" TO balo_salonu',
    'ALTER TABLE otel RENAME COLUMN "Kuaför" TO kuafor',
    'ALTER TABLE otel RENAME COLUMN "Otopark" TO otopark',
    'ALTER TABLE otel RENAME COLUMN "Market" TO market',
    'ALTER TABLE otel RENAME COLUMN "Sauna" TO sauna',
    'ALTER TABLE otel RENAME COLUMN "Doktor" TO doktor',
    'ALTER TABLE otel RENAME COLUMN "Beach Voley" TO beach_voley',
    'ALTER TABLE otel RENAME COLUMN "Fitness" TO fitness',
    'ALTER TABLE otel RENAME COLUMN "Canlı Eğlence" TO canli_eglence',
    'ALTER TABLE otel RENAME COLUMN "Wireless Internet" TO wireless_internet',
    'ALTER TABLE otel RENAME COLUMN "Animasyon" TO animasyon',
    'ALTER TABLE otel RENAME COLUMN "Sörf" TO sorf',
    'ALTER TABLE otel RENAME COLUMN "Paraşüt" TO parasut',
    'ALTER TABLE otel RENAME COLUMN "Araç Kiralama" TO arac_kiralama',
    'ALTER TABLE otel RENAME COLUMN "Kano" TO kano',
    'ALTER TABLE otel RENAME COLUMN "SPA" TO spa',
    'ALTER TABLE otel RENAME COLUMN "Masaj" TO masaj',
    'ALTER TABLE otel RENAME COLUMN "Masa Tenisi" TO masa_tenisi',
    'ALTER TABLE otel RENAME COLUMN "Çocuk Havuzu" TO cocuk_havuzu',
    'ALTER TABLE otel RENAME COLUMN "Çocuk Parkı" TO cocuk_parki'
]

# Her bir sorguyu çalıştırma
for query in rename_queries:
    cursor.execute(query)

# Değişiklikleri kaydetme
conn.commit()

# Veritabanı bağlantısını ve imleci kapatma
cursor.close()
conn.close()
