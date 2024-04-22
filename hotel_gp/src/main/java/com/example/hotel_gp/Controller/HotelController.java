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

    @GetMapping("/{id}")
    public Hotel getHotelById(@PathVariable("id") int id){

        return hotelService.findById(id).orElse(null);
    }
   /*  @GetMapping("/region/{region}")
    public List<Hotel> getHotelsByRegion(@PathVariable String region){
        return hotelService.findByRegion(region);
    }*/




}
