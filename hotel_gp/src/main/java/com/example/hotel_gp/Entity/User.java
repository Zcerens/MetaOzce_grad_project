package com.example.hotel_gp.Entity;

import jakarta.persistence.*;
import lombok.Data;


@Entity
@Data
@Table(name = "user_table")

public class User {
    @Id
    @Column(length =8)
    @GeneratedValue
    private int user_id;
    @Column(length = 40)
    private String fullname;
    @Column(length = 20, unique = true)
    private String username;
    @Column(length = 60)
    private String password;






}
