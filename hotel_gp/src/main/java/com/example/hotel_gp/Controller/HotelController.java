package com.example.hotel_gp.Controller;

import com.example.hotel_gp.Entity.Hotel;
import com.example.hotel_gp.Service.HotelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/hotel")

public class HotelController {
    @Autowired
    private HotelService hotelService;

    @GetMapping("/{hotel_id}")
    public Hotel getHotelById(@PathVariable int hotel_id){

        return hotelService.findById(hotel_id).orElse(null);
    }
    @GetMapping("/region/{region}")
    public List<Hotel> getHotelsByRegion(@PathVariable String region){
        return hotelService.findByRegion(region);
    }




}
