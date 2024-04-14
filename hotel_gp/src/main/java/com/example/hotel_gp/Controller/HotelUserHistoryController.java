package com.example.hotel_gp.Controller;

import com.example.hotel_gp.Entity.HotelUserHistory;
import com.example.hotel_gp.Service.HotelUserHistoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/hotel-user")
public class HotelUserHistoryController {
    @Autowired
    private HotelUserHistoryService hotelUserHistoryService;

    @GetMapping("/{id}")
    public HotelUserHistory getHistoryById(@PathVariable int id){
        return hotelUserHistoryService.findById(id).orElse(null);
    }

    @PostMapping
    public HotelUserHistory createHistory(@RequestBody HotelUserHistory hotelUserHistory){
        return hotelUserHistoryService.saveOrUpdate(hotelUserHistory);
    }

    @PutMapping("/{id}")
    public HotelUserHistory updateHistory(@PathVariable int id, @RequestBody HotelUserHistory hotelUserHistory){
        hotelUserHistory.setHotel_id(id);
        return hotelUserHistoryService.saveOrUpdate(hotelUserHistory);
    }

    @DeleteMapping("/{id}")
    public void deleteHistory(@PathVariable int id){
        hotelUserHistoryService.deleteById(id);
    }
}
