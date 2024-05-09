import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; 
class PythonEntegration {
  final Dio _dio = Dio();
 List <dynamic> hotels =[];

Future<dynamic> getAllRecommendHotels(String oncekiOtelAd) async {
    try {
      final response = await _dio.get(
        'http://80.253.246.51:5000/onerilen-oteller/$oncekiOtelAd',
      );
      final responseData = response.data;
  hotels = responseData;
     
      return responseData;
    } catch (error) {
      print('Error fetching hotel with getAllRecommendHotels : $error'); // Hata mesajını yazdır
      throw Exception('Failed to get hotel with getAllRecommendHotels: $error');
    }
  }
  
}

void main() async {
  final PythonEntegration pythonEntegration = PythonEntegration();

  // HotelService'deki getHotelWithId metodunu çağırarak bir otel al
  try {
    final hotelData = await pythonEntegration.getAllRecommendHotels("Adam Eve");

    print('Hotel Data: $hotelData');
  } catch (e) {
    print('Error: $e');
  }
}