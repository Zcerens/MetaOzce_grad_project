package com.metaozce.metaozce.Controller;

import com.metaozce.metaozce.DAO.HotelDAO;
import com.metaozce.metaozce.Entity.Hotel;
import com.metaozce.metaozce.Service.HotelService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController

@RequestMapping("/hotels")
public class HotelController {

    HotelService hotelService;
    private HotelDAO hotelDAO;

    HotelController(HotelService hotelService){
        this.hotelService=hotelService;

    }
    @GetMapping("/read")
    public List<Hotel> getAllHotels() {
        return hotelService.getAllHotels();
    }


    @GetMapping("/read/{id}")
    public Hotel getHotelById(@PathVariable Integer id) {

        return hotelService.getHotelsById(id);
    }
}
