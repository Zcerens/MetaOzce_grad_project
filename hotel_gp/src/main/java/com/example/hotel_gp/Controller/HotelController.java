package com.example.hotel_gp.Controller;

import com.example.hotel_gp.Entity.Hotel;
import com.example.hotel_gp.Service.HotelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/hotel")

public class HotelController {
    @Autowired
    private HotelService hotelService;

    @GetMapping("/{hotel_id}")
    public Hotel getHotelById(@PathVariable int hotel_id){
        return hotelService.findById(hotel_id).orElse(null);
    }

    @PostMapping
    public Hotel createHotel(@RequestBody Hotel hotel){
        return hotelService.saveOrUpdate(hotel);
    }

    @PutMapping("/{hotel_id}")
    public Hotel updateHotel(@PathVariable int hotel_id, @RequestBody Hotel hotel){
        hotel.setHotel_id(hotel_id);
        return hotelService.saveOrUpdate(hotel);
    }

    @DeleteMapping("/{hotel_id}")
    public void deleteHotel(@PathVariable int hotel_id){
        hotelService.deleteById(hotel_id);
    }
}
