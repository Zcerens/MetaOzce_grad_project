package com.example.hotel_gp.Controller;

import com.example.hotel_gp.Entity.User;
import com.example.hotel_gp.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
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

    @PostMapping
    public User createUser(@RequestBody User user){
        return userService.saveOrUpdate(user);
    }

    @PutMapping("/{user_id}")
    public User updateUser(@PathVariable int user_id, @RequestBody User user){
        user.setUser_id(user_id);
        return userService.saveOrUpdate(user);
    }

    @DeleteMapping("/{user_id}")
    public void deleteUser(@PathVariable int user_id){
        userService.deleteById(user_id);
    }
}
