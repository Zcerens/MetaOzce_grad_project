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

    @Column(name = "fiyat_araligi", length = 250)
    private String fiyatAraligi;

    @Column(name = "bolge", length = 250)
    private String bolge;

    @Column(name = "hava_alanina_uzakligi")
    private String havaAlaninaUzakligi;

    @Column(name = "denize_uzakligi")
    private String denizeUzakligi;

    @Column(name = "plaj")
    private String plaj;

    @Column(name = "iskele")
    private String iskele;

    @Column(name = "a_la_carte_restoran")
    private String aLaCarteRestoran;

    @Column(name = "asansor")
    private String asansor;

    @Column(name = "acik_restoran")
    private String acikRestoran;

    @Column(name = "kapali_restoran")
    private String kapaliRestoran;

    @Column(name = "acik_havuz")
    private String acikHavuz;

    @Column(name = "kapali_havuz")
    private String kapaliHavuz;

    @Column(name = "bedensel_engelli_odasi")
    private String bedenselEngelliOdasi;

    @Column(name = "bar")
    private String bar;

    @Column(name = "su_kaydiragi")
    private String suKaydiragi;

    @Column(name = "balo_salonu")
    private String baloSalonu;

    @Column(name = "kuafor")
    private String kuaför;

    @Column(name = "otopark")
    private String otopark;

    @Column(name = "market")
    private String market;

    @Column(name = "sauna")
    private String sauna;

    @Column(name = "doktor")
    private String doktor;

    @Column(name = "beach_voley")
    private String beachVoley;

    @Column(name = "fitness")
    private String fitness;

    @Column(name = "canli_eglence")
    private String canliEglence;

    @Column(name = "wireless_internet")
    private String wirelessInternet;

    @Column(name = "animasyon")
    private String animasyon;

    @Column(name = "sorf")
    private String sorf;

    @Column(name = "parasut")
    private String parasut;

    @Column(name = "arac_kiralama")
    private String aracKiralama;

    @Column(name = "kano")
    private String kano;

    @Column(name = "spa")
    private String spa;

    @Column(name = "masaj")
    private String masaj;

    @Column(name = "masa_tenisi")
    private String masaTenisi;

    @Column(name = "cocuk_havuzu")
    private String cocukHavuzu;

    @Column(name = "cocuk_parki")
    private String cocukParki;

    // Getter ve setter'lar
}
