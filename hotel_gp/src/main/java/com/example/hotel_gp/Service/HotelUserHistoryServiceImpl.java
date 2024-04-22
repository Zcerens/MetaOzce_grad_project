package com.example.hotel_gp.Service;

import com.example.hotel_gp.Entity.HotelUserHistory;
import com.example.hotel_gp.Repository.HotelUserHistoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
@Service

public class HotelUserHistoryServiceImpl implements HotelUserHistoryService{
    @Autowired
    private HotelUserHistoryRepository hotelUserHistoryRepository;
    @Override
    public List<HotelUserHistory> findAll() {
        return hotelUserHistoryRepository.findAll();
    }

    @Override
    public Optional<HotelUserHistory> findById(int id) {
        return hotelUserHistoryRepository.findById(id);
    }

    @Override//TODO create and update
    public Integer saveOrUpdate(HotelUserHistory hotelUserHistory) {
        return hotelUserHistoryRepository.save(hotelUserHistory).getId();
    }

    @Override
    public void deleteById(int id) {
        hotelUserHistoryRepository.deleteById(id);

    }
}
