import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  Future<void> cacheUserData(String id, String fullname, String username, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', id);
    await prefs.setString('userFullname', fullname);
    await prefs.setString('userUsername', username);
    await prefs.setString('userPassword', password);
  }

  Future<Map<String, String>> getCachedUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? id = prefs.getString('userId');
    final String? fullname = prefs.getString('userFullname');
    final String? username = prefs.getString('userUsername');
    final String? password = prefs.getString('userPassword');

    if (id != null && fullname != null && username != null && password != null) {
      return {
        'id': id,
        'fullname': fullname,
        'username': username,
        'password': password,
      };
    } else {
      throw Exception('Cached user data not found');
    }
  }
}