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
    public ResponseEntity<List<Hotel>> findAllHotels(@RequestParam(name = "numberStr",required = false) String numberStr,
                                                      @RequestParam(name ="feature", required = false) String feature) {
         int number=0 ;

        if (numberStr != null) {
            number = Integer.parseInt(numberStr);
        }
                                                       
        List<Hotel> hotels;
        if (feature == null) {
            hotels = hotelService.findAll();
        } else {
            hotels = hotelService.findByAllColumnsContainingAndNumberGreaterThanEqual(feature, number);
        }
        return ResponseEntity.ok(hotels);
    }
   /*  @GetMapping("/region/{region}")
    public List<Hotel> getHotelsByRegion(@PathVariable String region){
        return hotelService.findByRegion(region);
    }*/


    @GetMapping("/sortedByPrice")
    public List<Hotel> getAllHotelsSortedByPrice() {
        return hotelService.getAllHotelsSortedByPrice();
    }




}