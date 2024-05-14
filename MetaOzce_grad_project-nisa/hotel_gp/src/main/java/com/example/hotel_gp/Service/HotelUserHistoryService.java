package com.example.hotel_gp.Service;

import com.example.hotel_gp.Entity.HotelUserHistory;

import java.util.*;

public interface HotelUserHistoryService {
    List<HotelUserHistory> findAll();
    Optional<HotelUserHistory> findById(int id);
    Integer saveOrUpdate(HotelUserHistory hotelUserHistory);
    void deleteById(int id);
    List<HotelUserHistory> findByUserId(int userId);
    void deleteHotelFromHotelUserHistory(int userId, int hotelId);
    boolean isHotelAlreadyAdded(int userId, int hotelId);
    


}


