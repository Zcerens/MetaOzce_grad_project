from flask import Flask, jsonify
import pandas as pd
from sklearn.metrics.pairwise import cosine_similarity
import numpy as np

app = Flask(__name__)

# Veri setini yükleme
data = pd.read_csv("duzenlenmis_otel_veritabani_DB4.csv")
data.dropna(inplace=True)

# Önerilen otelleri bulan fonksiyon
def onerilen_otelleri_bul(onceki_otel_ad):
    if not onceki_otel_ad or onceki_otel_ad not in data['otel_ad'].values:
        # Eğer otel adı geçerli değilse veya null ise rastgele 3 otel döndür
        onerilen_oteller = data.sample(3)
    else:
        # Önceki otelin özelliklerini bulma
        onceki_otel = data[data['otel_ad'] == onceki_otel_ad].drop(columns=['otel_ad', 'fiyat','imageurl', 'bolge'])

        # Veri setindeki diğer otellerin özelliklerini al
        diger_oteller = data.drop(columns=['otel_ad', 'fiyat','imageurl', 'bolge'])

        # Cosine similarity kullanarak benzerlik ölçüsünü hesaplama
        benzerlik_skorlari = cosine_similarity(onceki_otel, diger_oteller)

        # En uygun otellerin indekslerini bulma (kendisini hariç tutarak)
        en_uygun_otel_indeksleri = benzerlik_skorlari.flatten().argsort()[-4:-1]

        # Önerilen otellerin tüm bilgileri
        onerilen_oteller = data.iloc[en_uygun_otel_indeksleri]

    # DataFrame'i Python sözlüğüne dönüştürme
    onerilen_oteller_dict = onerilen_oteller.to_dict(orient='records')

    return onerilen_oteller_dict

# API endpoint'i
@app.route('/onerilen-oteller/<string:onceki_otel_ad>', methods=['GET'])
def onerilen_oteller_endpoint(onceki_otel_ad):
    onerilen_oteller = onerilen_otelleri_bul(onceki_otel_ad)
    return jsonify(onerilen_oteller)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
