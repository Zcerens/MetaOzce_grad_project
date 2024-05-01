package com.example.hotel_gp.Controller;

import com.example.hotel_gp.Entity.Hotel;
import com.example.hotel_gp.Entity.HotelUserHistory;
import com.example.hotel_gp.Entity.User;
import com.example.hotel_gp.Service.HotelUserHistoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/hotel-user")
public class HotelUserHistoryController {
    @Autowired
    private HotelUserHistoryService hotelUserHistoryService;

    @GetMapping("/{id}")
    public HotelUserHistory getHistoryById(@PathVariable("id") int id){
        return hotelUserHistoryService.findById(id).orElse(null);
    }
    
    @PostMapping("/create")
    public ResponseEntity<String> createHistory(@RequestBody HotelUserHistory hotelUserHistory){
        ResponseEntity<String> responseEntity = null;
        try {
            Integer integer = Integer.valueOf(hotelUserHistoryService.saveOrUpdate(hotelUserHistory));
            responseEntity = new ResponseEntity<String>("Account " + integer + " created", HttpStatus.OK);
        } catch (Exception e) {
            responseEntity = new ResponseEntity<String>(e.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        }

        return responseEntity;
    }

    @GetMapping("/get")
    public ResponseEntity<List<HotelUserHistory>> findAllUsers(){
        return ResponseEntity.ok(hotelUserHistoryService.findAll());
    }

    @GetMapping("/user/{userId}")
public List<HotelUserHistory> getHistoryByUserId(@PathVariable("userId") int userId) {
    return hotelUserHistoryService.findByUserId(userId);
}

    

//    @PutMapping("/update/{id}")
//    public HotelUserHistory updateHistory(@PathVariable Hotel hotel, @RequestBody HotelUserHistory hotelUserHistory){
//        hotelUserHistory.setHotel(hotel);
//        return hotelUserHistoryService.saveOrUpdate(hotelUserHistory);
//    }

    @DeleteMapping("/{id}")
    public void deleteHistory(@PathVariable int id){
        hotelUserHistoryService.deleteById(id);
    }
}
