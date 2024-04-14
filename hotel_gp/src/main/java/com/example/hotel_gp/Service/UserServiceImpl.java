package com.example.hotel_gp.Service;

import com.example.hotel_gp.Entity.User;
import com.example.hotel_gp.Repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
@Service

public class UserServiceImpl implements UserService{
    @Autowired
    private UserRepository userRepository;
    @Override
    public List<User> findAll() {
        return userRepository.findAll();
    }

    @Override
    public Optional<User> findById(int user_id) {
        return userRepository.findById(user_id);
    }

    @Override
    public User saveOrUpdate(User user) {

        return userRepository.save(user);
    }

    @Override
    public void deleteById(int user_id) {
        userRepository.deleteById(user_id);

    }
}
