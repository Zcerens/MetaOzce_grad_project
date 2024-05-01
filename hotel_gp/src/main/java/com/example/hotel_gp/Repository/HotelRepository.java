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
    "(:keyword = 'iskele' AND h.iskele >= :number) OR " +
    "(:keyword = 'a_la_carte_restoran' AND h.a_la_carte_restoran >= :number) OR " +
    "(:keyword = 'asansor' AND h.asansor >= :number) OR " +
    "(:keyword = 'acik_restoran' AND h.acik_restoran >= :number) OR " +
    "(:keyword = 'kapali_restoran' AND h.kapali_restoran >= :number) OR " +
    "(:keyword = 'acik_havuz' AND h.acik_havuz >= :number) OR " +
    "(:keyword = 'kapali_havuz' AND h.kapali_havuz >= :number) OR " +
    "(:keyword = 'bedensel_engelli_odasi' AND h.bedensel_engelli_odasi >= :number) OR " +
    "(:keyword = 'bar' AND h.bar >= :number) OR " +
    "(:keyword = 'su_kaydiragi' AND h.su_kaydiragi >= :number) OR " +
    "(:keyword = 'balo_salonu' AND h.balo_salonu >= :number) OR " +
    "(:keyword = 'kuafor' AND h.kuafor >= :number) OR " +
    "(:keyword = 'otopark' AND h.otopark >= :number) OR " +
    "(:keyword = 'market' AND h.market >= :number) OR " +
    "(:keyword = 'sauna' AND h.sauna >= :number) OR " +
    "(:keyword = 'doktor' AND h.doktor >= :number) OR " +
    "(:keyword = 'beach_voley' AND h.beach_voley >= :number) OR " +
    "(:keyword = 'fitness' AND h.fitness >= :number) OR " +
    "(:keyword = 'canli_eglence' AND h.canli_eglence >= :number) OR " +
    "(:keyword = 'wireless_internet' AND h.wireless_internet >= :number) OR " +
    "(:keyword = 'animasyon' AND h.animasyon >= :number) OR " +
    "(:keyword = 'sorf' AND h.sorf >= :number) OR " +
    "(:keyword = 'parasut' AND h.parasut >= :number) OR " +
    "(:keyword = 'arac_kiralama' AND h.arac_kiralama >= :number) OR " +
    "(:keyword = 'kano' AND h.kano >= :number) OR " +
    "(:keyword = 'spa' AND h.spa >= :number) OR " +
    "(:keyword = 'masaj' AND h.masaj >= :number) OR " +
    "(:keyword = 'masa_tenisi' AND h.masa_tenisi >= :number) OR " +
    "(:keyword = 'cocuk_havuzu' AND h.cocuk_havuzu >= :number) OR " +
    "(:keyword = 'cocuk_parki' AND h.cocuk_parki >= :number)")
List<Hotel> findByAllColumnsContainingAndNumberGreaterThanEqual(@Param("keyword") String keyword, @Param("number") int number);
}
