package com.example.hotel_gp.Service;

import com.example.hotel_gp.Entity.Hotel;

import java.util.List;
import java.util.Optional;

public interface HotelService {
    List<Hotel> findAll();
    Optional<Hotel> findById(int hotel_id);
    Hotel saveOrUpdate(Hotel hotel);
    void deleteById(int hotel_id);

}
