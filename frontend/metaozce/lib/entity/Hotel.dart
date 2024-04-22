class Hotel {
  final int id;
  final String otelAd;
  final double fiyat;
  final String fiyatAraligi;
  final String bolge;
  final double havaAlaninaUzakligi;
  final String denizeUzakligi;
  final String plaj;
  final int iskele;
  final int asansor;
  final int acikRestoran;
  final int kapaliRestoran;
  final int acikHavuz;
  final int kapaliHavuz;
  final int bedenselEngelliOdasi;
  final int bar;
  final int suKaydiragi;
  final int baloSalonu;
  final int kuafor;
  final int otopark;
  final int market;
  final int sauna;
  final int doktor;
  final int beachVoley;
  final int fitness;
  final int canliEglence;
  final int wirelessInternet;
  final int animasyon;
  final int sorf;
  final int parasut;
  final int aracKiralama;
  final int kano;
  final int spa;
  final int masaj;
  final int masaTenisi;
  final int cocukHavuzu;
  final int cocukParki;
  final int alaCarteRestoran;

  Hotel({
    required this.id,
    required this.otelAd,
    required this.fiyat,
    required this.fiyatAraligi,
    required this.bolge,
    required this.havaAlaninaUzakligi,
    required this.denizeUzakligi,
    required this.plaj,
    required this.iskele,
    required this.asansor,
    required this.acikRestoran,
    required this.kapaliRestoran,
    required this.acikHavuz,
    required this.kapaliHavuz,
    required this.bedenselEngelliOdasi,
    required this.bar,
    required this.suKaydiragi,
    required this.baloSalonu,
    required this.kuafor,
    required this.otopark,
    required this.market,
    required this.sauna,
    required this.doktor,
    required this.beachVoley,
    required this.fitness,
    required this.canliEglence,
    required this.wirelessInternet,
    required this.animasyon,
    required this.sorf,
    required this.parasut,
    required this.aracKiralama,
    required this.kano,
    required this.spa,
    required this.masaj,
    required this.masaTenisi,
    required this.cocukHavuzu,
    required this.cocukParki,
    required this.alaCarteRestoran,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'otelAd': otelAd,
      'fiyat': fiyat,
      'fiyatAraligi': fiyatAraligi,
      'bolge': bolge,
      'havaAlaninaUzakligi': havaAlaninaUzakligi,
      'denizeUzakligi': denizeUzakligi,
      'plaj': plaj,
      'iskele': iskele,
      'asansor': asansor,
      'acikRestoran': acikRestoran,
      'kapaliRestoran': kapaliRestoran,
      'acikHavuz': acikHavuz,
      'kapaliHavuz': kapaliHavuz,
      'bedenselEngelliOdasi': bedenselEngelliOdasi,
      'bar': bar,
      'suKaydiragi': suKaydiragi,
      'baloSalonu': baloSalonu,
      'kuafor': kuafor,
      'otopark': otopark,
      'market': market,
      'sauna': sauna,
      'doktor': doktor,
      'beachVoley': beachVoley,
      'fitness': fitness,
      'canliEglence': canliEglence,
      'wirelessInternet': wirelessInternet,
      'animasyon': animasyon,
      'sorf': sorf,
      'parasut': parasut,
      'aracKiralama': aracKiralama,
      'kano': kano,
      'spa': spa,
      'masaj': masaj,
      'masaTenisi': masaTenisi,
      'cocukHavuzu': cocukHavuzu,
      'cocukParki': cocukParki,
      'alaCarteRestoran': alaCarteRestoran,
    };
  }
}
