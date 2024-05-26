import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailService {
  final Dio _dio = Dio();
  Future<dynamic> getHotelById(int id) async {
    try {
      final response = await _dio.get(
        'http://80.253.246.51:8080/hotel/$id',
      );
      final responseData = response.data;

      return responseData;
    } catch (error) {
      print('Error fetching hotel with ID : $error'); // Hata mesajını yazdır
      throw Exception('Failed to get hotel with ID: $error');
    }
  }
}
