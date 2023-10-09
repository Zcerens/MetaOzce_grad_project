package com.metaozce.metaozce.DAO;

import com.metaozce.metaozce.Entity.Hotel;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

@Repository
@Component
public interface HotelDAO extends JpaRepository<Hotel,Integer> {

}