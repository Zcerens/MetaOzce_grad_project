package com.example.hotel_gp.Repository;
import com.example.hotel_gp.Entity.HotelUserHistory;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository

public interface HotelUserHistoryRepository extends JpaRepository<HotelUserHistory, Integer>{
}
