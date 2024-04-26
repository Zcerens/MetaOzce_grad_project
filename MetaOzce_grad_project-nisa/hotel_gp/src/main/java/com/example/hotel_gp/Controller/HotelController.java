package com.example.hotel_gp.Controller;

import com.example.hotel_gp.Entity.Hotel;
import com.example.hotel_gp.Service.HotelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/hotel")

public class HotelController {
    @Autowired
    private HotelService hotelService;

    @GetMapping("/{id}")
    public ResponseEntity<?> getHotelById(@PathVariable("id") int id){

        return ResponseEntity.status(HttpStatus.ACCEPTED).body(hotelService.findHotelById(id).orElse(null));


    }

    @GetMapping("/get")
    public ResponseEntity<List<Hotel>> findAllHotels(){
        return ResponseEntity.ok(hotelService.findAll());
    }
   /*  @GetMapping("/region/{region}")
    public List<Hotel> getHotelsByRegion(@PathVariable String region){
        return hotelService.findByRegion(region);
    }*/




}
