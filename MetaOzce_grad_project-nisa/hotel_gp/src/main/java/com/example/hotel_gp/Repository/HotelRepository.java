package com.example.hotel_gp.Repository;

import com.example.hotel_gp.Entity.Hotel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface HotelRepository extends JpaRepository<Hotel, Integer> {
    Optional<Hotel> findById(int id);

    @Query("SELECT h FROM Hotel h WHERE" + "(:number = 0 AND " 
    + "(CASE "
            + "WHEN (:keyword = 'iskele' AND h.iskele = 0) THEN 1 "
            + "WHEN (:keyword = 'a_la_carte_restoran' AND h.a_la_carte_restoran = 0) THEN 1 "
            + "WHEN (:keyword = 'asansor' AND h.asansor = 0) THEN 1 "
            + "WHEN (:keyword = 'acik_restoran' AND h.acik_restoran = 0) THEN 1 "
            + "WHEN (:keyword = 'kapali_restoran' AND h.kapali_restoran = 0) THEN 1 "
            + "WHEN (:keyword = 'acik_havuz' AND h.acik_havuz = 0) THEN 1 "
            + "WHEN (:keyword = 'kapali_havuz' AND h.kapali_havuz = 0) THEN 1 "
            + "WHEN (:keyword = 'bedensel_engelli_odasi' AND h.bedensel_engelli_odasi = 0) THEN 1 "
            + "WHEN (:keyword = 'bar' AND h.bar = 0) THEN 1 "
            + "WHEN (:keyword = 'su_kaydiragi' AND h.su_kaydiragi = 0) THEN 1 "
            + "WHEN (:keyword = 'balo_salonu' AND h.balo_salonu = 0) THEN 1 "
            + "WHEN (:keyword = 'kuafor' AND h.kuafor = 0) THEN 1 "
            + "WHEN (:keyword = 'otopark' AND h.otopark = 0) THEN 1 "
            + "WHEN (:keyword = 'market' AND h.market = 0) THEN 1 "
            + "WHEN (:keyword = 'sauna' AND h.sauna = 0) THEN 1 "
            + "WHEN (:keyword = 'doktor' AND h.doktor = 0) THEN 1 "
            + "WHEN (:keyword = 'beach_voley' AND h.beach_voley = 0) THEN 1 "
            + "WHEN (:keyword = 'fitness' AND h.fitness = 0) THEN 1 "
            + "WHEN (:keyword = 'canli_eglence' AND h.canli_eglence = 0) THEN 1 "
            + "WHEN (:keyword = 'wireless_internet' AND h.wireless_internet = 0) THEN 1 "
            + "WHEN (:keyword = 'animasyon' AND h.animasyon = 0) THEN 1 "
            + "WHEN (:keyword = 'sorf' AND h.sorf = 0) THEN 1 "
            + "WHEN (:keyword = 'parasut' AND h.parasut = 0) THEN 1 "
            + "WHEN (:keyword = 'arac_kiralama' AND h.arac_kiralama = 0) THEN 1 "
            + "WHEN (:keyword = 'kano' AND h.kano = 0) THEN 1 " + "WHEN (:keyword = 'spa' AND h.spa = 0) THEN 1 "
            + "WHEN (:keyword = 'masaj' AND h.masaj = 0) THEN 1 "
            + "WHEN (:keyword = 'masa_tenisi' AND h.masa_tenisi = 0) THEN 1 "
            + "WHEN (:keyword = 'cocuk_havuzu' AND h.cocuk_havuzu = 0) THEN 1 "
            + "WHEN (:keyword = 'cocuk_parki' AND h.cocuk_parki = 0) THEN 1 " + "ELSE 0 END) = 1) OR "
            + "(:number != 0 AND " + "(CASE " + "WHEN (:keyword = 'iskele' AND h.iskele >= :number) THEN 1 "
            + "WHEN (:keyword = 'a_la_carte_restoran' AND h.a_la_carte_restoran >= :number) THEN 1 "
            + "WHEN (:keyword = 'asansor' AND h.asansor >= :number) THEN 1 "
            + "WHEN (:keyword = 'acik_restoran' AND h.acik_restoran >= :number) THEN 1 "
            + "WHEN (:keyword = 'kapali_restoran' AND h.kapali_restoran >= :number) THEN 1 "
            + "WHEN (:keyword = 'acik_havuz' AND h.acik_havuz >= :number) THEN 1 "
            + "WHEN (:keyword = 'kapali_havuz' AND h.kapali_havuz >= :number) THEN 1 "
            + "WHEN (:keyword = 'bedensel_engelli_odasi' AND h.bedensel_engelli_odasi >= :number) THEN 1 "
            + "WHEN (:keyword = 'bar' AND h.bar >= :number) THEN 1 "
            + "WHEN (:keyword = 'su_kaydiragi' AND h.su_kaydiragi >= :number) THEN 1 "
            + "WHEN (:keyword = 'balo_salonu' AND h.balo_salonu >= :number) THEN 1 "
            + "WHEN (:keyword = 'kuafor' AND h.kuafor >= :number) THEN 1 "
            + "WHEN (:keyword = 'otopark' AND h.otopark >= :number) THEN 1 "
            + "WHEN (:keyword = 'market' AND h.market >= :number) THEN 1 "
            + "WHEN (:keyword = 'sauna' AND h.sauna >= :number) THEN 1 "
            + "WHEN (:keyword = 'doktor' AND h.doktor >= :number) THEN 1 "
            + "WHEN (:keyword = 'beach_voley' AND h.beach_voley >= :number) THEN 1 "
            + "WHEN (:keyword = 'fitness' AND h.fitness >= :number) THEN 1 "
            + "WHEN (:keyword = 'canli_eglence' AND h.canli_eglence >= :number) THEN 1 "
            + "WHEN (:keyword = 'wireless_internet' AND h.wireless_internet >= :number) THEN 1 "
            + "WHEN (:keyword = 'animasyon' AND h.animasyon >= :number) THEN 1 "
            + "WHEN (:keyword = 'sorf' AND h.sorf >= :number) THEN 1 "
            + "WHEN (:keyword = 'parasut' AND h.parasut >= :number) THEN 1 "
            + "WHEN (:keyword = 'arac_kiralama' AND h.arac_kiralama >= :number) THEN 1 "
            + "WHEN (:keyword = 'kano' AND h.kano >= :number) THEN 1 "
            + "WHEN (:keyword = 'spa' AND h.spa >= :number) THEN 1 "
            + "WHEN (:keyword = 'masaj' AND h.masaj >= :number) THEN 1 "
            + "WHEN (:keyword = 'masa_tenisi' AND h.masa_tenisi >= :number) THEN 1 "
            + "WHEN (:keyword = 'cocuk_havuzu' AND h.cocuk_havuzu >= :number) THEN 1 " +
            "WHEN (:keyword = 'cocuk_parki' AND h.cocuk_parki >= :number) THEN 1 " + "ELSE 0 END) = 1)" )
            
    List<Hotel> findByAllColumnsContainingAndNumberGreaterThanEqual(@Param("keyword") String keyword,
            @Param("number") int number);

}
