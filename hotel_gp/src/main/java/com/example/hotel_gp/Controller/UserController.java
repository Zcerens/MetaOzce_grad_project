package com.example.hotel_gp.Controller;

import com.example.hotel_gp.Entity.User;
import com.example.hotel_gp.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/user")


public class UserController {
    @Autowired
    private UserService userService;
    @GetMapping("/{user_id}")
    public User getUserById(@PathVariable int user_id){
        return userService.findById(user_id).orElse(null);
    }

    @PostMapping("/create")
    public ResponseEntity<?> createUser(@RequestBody User user) {
        // Kullanıcı adının benzersiz olduğunu kontrol et
        if (!userService.existsByUsername(user.getUsername())) {
            // Eğer kullanıcı adı benzersizse, kullanıcıyı oluştur ve 201 Created durumuyla geri dön
            User createdUser = userService.createUser(user);
            return ResponseEntity.status(HttpStatus.CREATED).body(createdUser);
        } else {
            // Eğer kullanıcı adı zaten varsa, 409 Conflict durumuyla birlikte özel bir mesaj döndür
            return ResponseEntity.status(HttpStatus.CONFLICT).body("Username is already in use.");
        }
    }

    @PutMapping("/{user_id}")
    public User updateUser(@PathVariable int user_id, @RequestBody User user){
        user.setUser_id(user_id);
        return userService.saveOrUpdate(user);
    }


}
