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
    public Optional<Hotel> findById(int hotel_id) {
        return hotelRepository.findById(hotel_id);
    }

    @Override
    public Hotel saveOrUpdate(Hotel hotel) {
        return hotelRepository.save(hotel);
    }

    @Override
    public void deleteById(int hotel_id) {
        hotelRepository.deleteById(hotel_id);

    }
}
