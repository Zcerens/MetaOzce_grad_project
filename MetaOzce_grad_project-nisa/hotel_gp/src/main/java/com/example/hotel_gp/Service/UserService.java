package com.example.hotel_gp.Service;

import com.example.hotel_gp.Entity.User;

import java.util.List;
import java.util.Optional;

public interface UserService {

    List<User> findAll();

    Optional<User> findById(int id);

    User saveOrUpdate(User user);

    boolean existsByUsername(String username);

    User createUser(User user);

    Optional<User> loginUser(String username, String password);

    Optional<User> getUserById(int userId);

}
