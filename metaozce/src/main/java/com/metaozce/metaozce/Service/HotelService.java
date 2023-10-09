package com.metaozce.metaozce.Service;

import com.metaozce.metaozce.DAO.HotelDAO;
import com.metaozce.metaozce.Entity.Hotel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service

public class HotelService {
    @Autowired
    private HotelDAO hotelDAO;

    public  HotelService(HotelDAO hotelDAO){
        this.hotelDAO=hotelDAO;

    }

    public List<Hotel> getAllHotels() {

        return hotelDAO.findAll();
    }

    public Hotel getHotelsById(Integer id) {


        return hotelDAO.findById(id).get();
    }
}
