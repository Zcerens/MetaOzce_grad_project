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

    @Query("SELECT h FROM Hotel h WHERE " +
    "(:number = 0 AND " +
    "  (:keyword <> 'iskele' OR h.iskele <> 0) AND " +
    "  (:keyword <> 'a_la_carte_restoran' OR h.a_la_carte_restoran <> 0) AND " +
    "  (:keyword <> 'asansor' OR h.asansor <> 0) AND " +
    "  (:keyword <> 'acik_restoran' OR h.acik_restoran <> 0) AND " +
    "  (:keyword <> 'kapali_restoran' OR h.kapali_restoran <> 0) AND " +
    "  (:keyword <> 'acik_havuz' OR h.acik_havuz <> 0) AND " +
    "  (:keyword <> 'kapali_havuz' OR h.kapali_havuz <> 0) AND " +
    "  (:keyword <> 'bedensel_engelli_odasi' OR h.bedensel_engelli_odasi <> 0) AND " +
    "  (:keyword <> 'bar' OR h.bar <> 0) AND " +
    "  (:keyword <> 'su_kaydiragi' OR h.su_kaydiragi <> 0) AND " +
    "  (:keyword <> 'balo_salonu' OR h.balo_salonu <> 0) AND " +
    "  (:keyword <> 'kuafor' OR h.kuafor <> 0) AND " +
    "  (:keyword <> 'otopark' OR h.otopark <> 0) AND " +
    "  (:keyword <> 'market' OR h.market <> 0) AND " +
    "  (:keyword <> 'sauna' OR h.sauna <> 0) AND " +
    "  (:keyword <> 'doktor' OR h.doktor <> 0) AND " +
    "  (:keyword <> 'beach_voley' OR h.beach_voley <> 0) AND " +
    "  (:keyword <> 'fitness' OR h.fitness <> 0) AND " +
    "  (:keyword <> 'canli_eglence' OR h.canli_eglence <> 0) AND " +
    "  (:keyword <> 'wireless_internet' OR h.wireless_internet <> 0) AND " +
    "  (:keyword <> 'animasyon' OR h.animasyon <> 0) AND " +
    "  (:keyword <> 'sorf' OR h.sorf <> 0) AND " +
    "  (:keyword <> 'parasut' OR h.parasut <> 0) AND " +
    "  (:keyword <> 'arac_kiralama' OR h.arac_kiralama <> 0) AND " +
    "  (:keyword <> 'kano' OR h.kano <> 0) AND " +
    "  (:keyword <> 'spa' OR h.spa <> 0) AND " +
    "  (:keyword <> 'masaj' OR h.masaj <> 0) AND " +
    "  (:keyword <> 'masa_tenisi' OR h.masa_tenisi <> 0) AND " +
    "  (:keyword <> 'cocuk_havuzu' OR h.cocuk_havuzu <> 0) AND " +
    "  (:keyword <> 'cocuk_parki' OR h.cocuk_parki <> 0)" +
    ") OR " +
    "(:number <> 0 AND " +
    "  (:keyword = 'iskele' AND h.iskele >= :number) OR " +
    "  (:keyword = 'a_la_carte_restoran' AND h.a_la_carte_restoran >= :number) OR " +
    "  (:keyword = 'asansor' AND h.asansor >= :number) OR " +
    "  (:keyword = 'acik_restoran' AND h.acik_restoran >= :number) OR " +
    "  (:keyword = 'kapali_restoran' AND h.kapali_restoran >= :number) OR " +
    "  (:keyword = 'acik_havuz' AND h.acik_havuz >= :number) OR " +
    "  (:keyword = 'kapali_havuz' AND h.kapali_havuz >= :number) OR " +
    "  (:keyword = 'bedensel_engelli_odasi' AND h.bedensel_engelli_odasi >= :number) OR " +
    "  (:keyword = 'bar' AND h.bar >= :number) OR " +
    "  (:keyword = 'su_kaydiragi' AND h.su_kaydiragi >= :number) OR " +
    "  (:keyword = 'balo_salonu' AND h.balo_salonu >= :number) OR " +
    "  (:keyword = 'kuafor' AND h.kuafor >= :number) OR " +
    "  (:keyword = 'otopark' AND h.otopark >= :number) OR " +
    "  (:keyword = 'market' AND h.market >= :number) OR " +
    "  (:keyword = 'sauna' AND h.sauna >= :number) OR " +
    "  (:keyword = 'doktor' AND h.doktor >= :number) OR " +
    "  (:keyword = 'beach_voley' AND h.beach_voley >= :number) OR " +
    "  (:keyword = 'fitness' AND h.fitness >= :number) OR " +
    "  (:keyword = 'canli_eglence' AND h.canli_eglence >= :number) OR " +
    "  (:keyword = 'wireless_internet' AND h.wireless_internet >= :number) OR " +
    "  (:keyword = 'animasyon' AND h.animasyon >= :number) OR " +
    "  (:keyword = 'sorf' AND h.sorf >= :number) OR " +
    "  (:keyword = 'parasut' AND h.parasut >= :number) OR " +
    "  (:keyword = 'arac_kiralama' AND h.arac_kiralama >= :number) OR " +
    "  (:keyword = 'kano' AND h.kano >= :number) OR " +
    "  (:keyword = 'spa' AND h.spa >= :number) OR " +
    "  (:keyword = 'masaj' AND h.masaj >= :number) OR " +
    "  (:keyword = 'masa_tenisi' AND h.masa_tenisi >= :number) OR " +
    "  (:keyword = 'cocuk_havuzu' AND h.cocuk_havuzu >= :number) OR " +
    "  (:keyword = 'cocuk_parki' AND h.cocuk_parki >= :number)" +
    ")")
List<Hotel> findByAllColumnsContainingAndNumberGreaterThanEqual(@Param("keyword") String keyword, @Param("number") int number);
}
