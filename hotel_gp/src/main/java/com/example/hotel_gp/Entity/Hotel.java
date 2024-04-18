package com.example.hotel_gp.Entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import lombok.Data;

@Entity
@Data

public class Hotel {
    @Id
    @Column(length = 8)
    @GeneratedValue
    private int hotel_id;
    @Column(length = 100)
    private String name;
    @Column (length = 250)
    private String region;

}
