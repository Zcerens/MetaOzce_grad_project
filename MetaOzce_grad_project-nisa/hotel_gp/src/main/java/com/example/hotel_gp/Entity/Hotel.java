package com.example.hotel_gp.Entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Data;
import jakarta.persistence.Column;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Entity
@Data
@Table(name = "otel")
@NoArgsConstructor
@AllArgsConstructor
public class Hotel {
    
    @Id 
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", columnDefinition = "INTEGER")
    private int id;

    @Column(name = "otel_ad", length = 250)
    private String otelAd;

    @Column(name = "fiyat")
    private String fiyat;

    @Column(name = "imageurl")
    private String imageurl;

    @Column(name = "score")
    private String score;

    @Column(name = "fiyat_araligi", length = 250)
    private String fiyat_araligi;

    @Column(name = "bolge", length = 250)
    private String bolge;

    @Column(name = "hava_alanina_uzakligi")
    private String hava_alanina_uzakligi;

    @Column(name = "denize_uzakligi")
    private String denizedenize_uzakligiUzakligi;

    @Column(name = "plaj")
    private String plaj;

    @Column(name = "iskele")
    private int iskele;

    @Column(name = "a_la_carte_restoran")
    private int a_la_carte_restoran;

    @Column(name = "asansor")
    private int asansor;

    @Column(name = "acik_restoran")
    private int acik_restoran;

    @Column(name = "kapali_restoran")
    private int kapali_restoran;

    @Column(name = "acik_havuz")
    private int acik_havuz;

    @Column(name = "kapali_havuz")
    private int kapali_havuz;

    @Column(name = "bedensel_engelli_odasi")
    private int bedensel_engelli_odasi;

    @Column(name = "bar")
    private int bar;

    @Column(name = "su_kaydiragi")
    private int su_kaydiragi;

    @Column(name = "balo_salonu")
    private int balo_salonu;

    @Column(name = "kuafor")
    private int kuafor;

    @Column(name = "otopark")
    private int otopark;

    @Column(name = "market")
    private int market;

    @Column(name = "sauna")
    private int sauna;

    @Column(name = "doktor")
    private int doktor;

    @Column(name = "beach_voley")
    private int beach_voley;

    @Column(name = "fitness")
    private int fitness;

    @Column(name = "canli_eglence")
    private int canli_eglence;

    @Column(name = "wireless_internet")
    private int wireless_internet;

    @Column(name = "animasyon")
    private int animasyon;

    @Column(name = "sorf")
    private int sorf;

    @Column(name = "parasut")
    private int parasut;

    @Column(name = "arac_kiralama")
    private int arac_kiralama;

    @Column(name = "kano")
    private int kano;

    @Column(name = "spa")
    private int spa;

    @Column(name = "masaj")
    private int masaj;

    @Column(name = "masa_tenisi")
    private int masa_tenisi;

    @Column(name = "cocuk_havuzu")
    private int cocuk_havuzu;

    @Column(name = "cocuk_parki")
    private int cocuk_parki;

    // Getter ve setter'lar
}
