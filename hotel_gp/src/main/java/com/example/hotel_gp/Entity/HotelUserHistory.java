package com.example.hotel_gp.Entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import lombok.Data;

@Entity
@Data

public class HotelUserHistory {
    @Id
    @GeneratedValue
    private int id;
    private int user_id;
    private int hotel_id;
}
