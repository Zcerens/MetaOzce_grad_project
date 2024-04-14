package com.example.hotel_gp.Service;

import com.example.hotel_gp.Entity.HotelUserHistory;

import java.util.List;
import java.util.Optional;

public interface HotelUserHistoryService {
    List<HotelUserHistory> findAll();
    Optional<HotelUserHistory> findById(int id);
    HotelUserHistory saveOrUpdate(HotelUserHistory hotelUserHistory);
    void deleteById(int id);
}
