package com.example.hotel_gp.Entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import lombok.Data;

@Entity
@Data

public class User {
    @Id
    @Column(length =8)
    @GeneratedValue
    private int user_id;
    @Column(length = 40)
    private String fullname;
    @Column(length = 20)
    private String username;
    @Column(length = 20)
    private String password;



}
