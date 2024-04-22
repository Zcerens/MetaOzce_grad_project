import 'package:dio/dio.dart';
import 'package:metaozce/entity/Hotel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HotelService {
  final Dio _dio = Dio();
  //final String _cacheKey = 'hotel_'; // Önbellek anahtarının başlangıcı
  List <dynamic> hotels =[];

  Future<dynamic> getHotelAll() async {
    try {
      //final SharedPreferences prefs = await SharedPreferences.getInstance();
      //final cachedData = prefs.getString(_cacheKey + id.toString());

      // if (cachedData != null) {
      //   // Önbellekte veri varsa, önbellekten dön
      //   print(cachedData);
      //   return cachedData;
      // } else {

      final response = await _dio.get(
        'http://80.253.246.51:8080/hotel/get',
      );
      final responseData = response.data;
      hotels = responseData;
      // print("VERİLER:");
      // print(responseData[0]);
      // print(responseData[0]['id']);
      // print("BLABLA\n\n");
      // print(hotels);
      // print(hotels[0]['otelAd']);

      // Önbelleğe alınacak veriyi kaydet
      //await prefs.setString(_cacheKey + id.toString(), responseData.toString());

      return hotels;
    } catch (error) {
      print('Error fetching hotel with ID : $error'); // Hata mesajını yazdır
      throw Exception('Failed to get hotel with ID: $error');
    }
  }


}

void main() async {
  final HotelService hotelService = HotelService();

  // HotelService'deki getHotelWithId metodunu çağırarak bir otel al
  try {
    //final hotelData = await hotelService.getHotelHistoryById(53);
    //print('Hotel Data: $hotelData');
  } catch (e) {
    print('Error: $e');
  }
}
