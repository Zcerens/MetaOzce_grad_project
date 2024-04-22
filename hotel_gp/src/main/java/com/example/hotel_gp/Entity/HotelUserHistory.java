package com.example.hotel_gp.Entity;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@Table(name = "hotel_user_history")
public class HotelUserHistory {
    @Id
    @GeneratedValue
    @Column(name="id")
    private int id;

    @JoinColumn(name = "user_id")
    @ManyToOne
    private User user;

    @JoinColumn(name = "hotel_id")
    @ManyToOne
    private Hotel hotel;
}
