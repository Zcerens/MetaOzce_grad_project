package com.example.hotel_gp.Entity;

import jakarta.persistence.*;
import lombok.Data;


@Entity
@Data
@Table(name = "user_table")

public class User {
    @Id    
    @GeneratedValue
    @Column(name="id")
    private int id;

    @Column(name="fullname",length = 20)
    private String fullname;

    @Column(name="username",length = 20, unique = true)
    private String username;
    
    @Column(name="password",length = 60)
    private String password;






}
