# -*- coding: utf-8 -*-
"""
Created on Sun Apr 14 00:38:27 2024

@author: ZC
"""

from flask import Flask, jsonify
import pandas as pd
from sklearn.metrics.pairwise import cosine_similarity

app = Flask(__name__)

# Veri setini yükleme
data = pd.read_csv("duzenlenmis_otel_veritabani_DB3.csv")
data.dropna(inplace=True)

# Önerilen otelleri bulan fonksiyon
def onerilen_otelleri_bul(onceki_otel_ad):
    # Önceki otelin özelliklerini bulma
    onceki_otel = data[data['otel_ad'] == onceki_otel_ad].drop(columns=['otel_ad', 'fiyat', 'il', 'ilce'])

    # Veri setindeki diğer otellerin özelliklerini al
    diget_oteller = data.drop(columns=['otel_ad', 'fiyat', 'il', 'ilce'])

    # Cosine similarity kullanarak benzerlik ölçüsünü hesaplama
    benzerlik_skorlari = cosine_similarity(onceki_otel, diget_oteller)

    # En uygun otellerin indekslerini bulma (kendisini hariç tutarak)
    en_uygun_otel_indeksleri = benzerlik_skorlari.flatten().argsort()[-4:-1]

    # Önerilen otellerin adlarını bulma
    onerilen_oteller_adlar = data.loc[en_uygun_otel_indeksleri, 'otel_ad'].tolist()

    return onerilen_oteller_adlar

#print(onerilen_otelleri_bul('Adam Eve'))

# API endpoint'i
@app.route('/onerilen-oteller/<string:onceki_otel_ad>', methods=['GET'])
def onerilen_oteller_endpoint(onceki_otel_ad):
    onerilen_oteller = onerilen_otelleri_bul(onceki_otel_ad)
    return jsonify(onerilen_oteller)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')

