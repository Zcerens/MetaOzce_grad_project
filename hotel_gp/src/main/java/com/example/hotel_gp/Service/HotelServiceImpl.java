package com.example.hotel_gp.Service;

import com.example.hotel_gp.Entity.Hotel;
import com.example.hotel_gp.Repository.HotelRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;


@Service

public class HotelServiceImpl implements HotelService{
    @Autowired
    private HotelRepository hotelRepository;

    @Override
    public List<Hotel> findAll() {
        return hotelRepository.findAll();
    }

    @Override
    //read
    public Optional<Hotel> findHotelById(int id) {
        return hotelRepository.findById(id);
    }

  

    @Override
    public List<Hotel> findByAllColumnsContainingAndNumberGreaterThanEqual(String feature, int number) {
       
            return hotelRepository.findByAllColumnsContainingAndNumberGreaterThanEqual(feature, number);
        
    }

  /*  @Override
    public List<Hotel> findByRegion(String region) {
        return hotelRepository.findByRegion(region);
    }*/
}
