import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailService {
  final Dio _dio = Dio();
  final String _cacheKey = 'hotel_'; // Önbellek anahtarının başlangıcı

  Future<dynamic> getHotelWithId(int id) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString(_cacheKey + id.toString());

      if (cachedData != null) {
        // Önbellekte veri varsa, önbellekten dön
        print(cachedData);
        return cachedData;
      } else {
        final response = await _dio.get(
          'http://80.253.246.51:8080/hotel/$id',
        );
        final responseData = response.data;
        
        // Önbelleğe alınacak veriyi kaydet
        await prefs.setString(_cacheKey + id.toString(), responseData.toString());

        return responseData;
      }
    } catch (error) {
      print('Error fetching hotel with ID $id: $error'); // Hata mesajını yazdır
      throw Exception('Failed to get hotel with ID: $error');
    }
  }
}

