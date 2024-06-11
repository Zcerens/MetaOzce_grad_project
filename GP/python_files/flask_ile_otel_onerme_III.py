from flask import Flask, jsonify, request
import pandas as pd
from sklearn.metrics.pairwise import cosine_similarity

app = Flask(__name__)

# Veri setini yükleme
data = pd.read_csv("duzenlenmis_otel_veritabani_DB4.csv")
data.dropna(inplace=True)

def onerilen_otelleri_bul(onceki_otel_ad, num_recommendations=3):
    # Önceki otelin özelliklerini bulma
    onceki_otel = data[data['otel_ad'] == onceki_otel_ad].drop(columns=['otel_ad', 'fiyat', 'imageurl', 'bolge'])
    
    if onceki_otel.empty:
        return {"error": "Geçersiz otel adı"}, 400

    # Veri setindeki diğer otellerin özelliklerini al
    diger_oteller = data.drop(columns=['otel_ad', 'fiyat', 'imageurl', 'bolge'])

    # Cosine similarity kullanarak benzerlik ölçüsünü hesaplama
    benzerlik_skorlari = cosine_similarity(onceki_otel, diger_oteller)

    # Benzerlik skorlarının belirli bir eşik değerin altında olup olmadığını kontrol et
    esik_degeri = 0.1  # Bu değeri ihtiyaca göre ayarla
    if benzerlik_skorlari.max() < esik_degeri:
        return {"error": "Benzeyen otel bulunamadı"}, 404

    # En uygun otellerin indekslerini bulma (kendisini hariç tutarak)
    en_uygun_otel_indeksleri = benzerlik_skorlari.flatten().argsort()[-num_recommendations-1:-1]

    # Önerilen otellerin tüm bilgileri
    onerilen_oteller = data.iloc[en_uygun_otel_indeksleri]

    # DataFrame'i py dict'e dönüştürme
    onerilen_oteller_dict = onerilen_oteller.to_dict(orient='records')

    return onerilen_oteller_dict

@app.route('/onerilen-oteller', methods=['GET'])
def onerilen_oteller_endpoint():
    onceki_otel_ad = request.args.get('otel_ad')
    if not onceki_otel_ad:
        return jsonify({"error": "Otel adı gerekli"}), 400
    onerilen_oteller = onerilen_otelleri_bul(onceki_otel_ad)
    if isinstance(onerilen_oteller, tuple) and onerilen_oteller[1] in [400, 404]:
        return jsonify(onerilen_oteller[0]), onerilen_oteller[1]
    return jsonify(onerilen_oteller)

if __name__ == '__main__':
    app.run(debug=False, host='0.0.0.0')