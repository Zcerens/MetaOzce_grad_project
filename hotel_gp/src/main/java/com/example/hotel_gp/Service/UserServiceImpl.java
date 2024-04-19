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
    public Optional<User> findById(int id) {
        return userRepository.findById(id);
    }

    @Override
    public User saveOrUpdate(User user) {

        return userRepository.save(user);
    }
    @Override
    public boolean existsByUsername(String username) {
        return userRepository.existsByUsername(username);
    }

    @Override
    public User createUser(User user) {
        if (!existsByUsername(user.getUsername())) {
            userRepository.save(user);
        } else {
            // Kullanıcı adı zaten var, gerekli işlem yapılabilir
            // Örneğin, istisna fırlatılabilir veya uygun bir geri bildirim sağlanabilir.
            throw new IllegalArgumentException("Username is already in use.");
        }
        return user;
    }


}
