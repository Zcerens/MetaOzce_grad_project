import 'package:dio/dio.dart';
import 'package:metaozce/entity/Hotel.dart';

class HotelUserHistoryService {
  final Dio _dio = Dio();


//TODO post örneği
  Future<Response> createHotelHistory(int hotel_id, int user_id) async {
    try {
      Map<String, dynamic> requestData = {
        'user': {'id': user_id},
        'hotel': {'id': hotel_id},
      };

      final response = await _dio.post(
        'http://80.253.246.51:8080/hotel-user/create',
        data: requestData,
      );
      return response;
    } catch (error) {
      throw Exception('Failed to create hotel history: $error');
    }
  }
 

  Future<dynamic> getAllHotelHistory() async {
    try {
      final response = await _dio.get(
        'http://80.253.246.51:8080/hotel-user/get',
      );
      final responseData = response.data;

     
      return responseData;
    } catch (error) {
      print('Error fetching getAllHotelHistory : $error'); // Hata mesajını yazdır
      throw Exception('Failed to get getAllHotelHistory: $error');
    }
  }

  Future<dynamic> getHotelHistoryById(int id) async {
    try {
      final response = await _dio.get(
        'http://80.253.246.51:8080/hotel-user/$id',
      );
      final responseData = response.data;

   //   print(responseData["user"]["fullname"]);
      return responseData;
    } catch (error) {
      print('Error fetching hotel with ID : $error'); // Hata mesajını yazdır
      throw Exception('Failed to get hotel with ID: $error');
    }
  }



//TODO get örneği
    Future<dynamic> getHotelHistoryByUserId(int userId) async {
    try {
      final response = await _dio.get(
        'http://80.253.246.51:8080/hotel-user/user/$userId',
      );
      final responseData = response.data;

      //print(responseData["user"]["fullname"]);
      return responseData;
    } catch (error) {
      print('Error fetching hotel with HotelHistoryByUserId : $error'); // Hata mesajını yazdır
      throw Exception('Failed to get hotel with HotelHistoryByUserId: $error');
    }
  }

    Future<Response> deleteHotelHistory(int user_id, int hotel_history_id) async {
    try {
     
      final response = await _dio.delete(
        'http://80.253.246.51:8080/hotel-user/user/$user_id/history/$hotel_history_id',
        
      );
      return response;
    } catch (error) {
      throw Exception('Failed to delete hotel history: $error');
    }
  }

}

void main() async {
  final HotelUserHistoryService hotelUserHistoryService = HotelUserHistoryService();

  // HotelService'deki getHotelWithId metodunu çağırarak bir otel al
  try {
    final hotelData = await hotelUserHistoryService.deleteHotelHistory(102,302);

    print('Hotel Data: $hotelData');
  } catch (e) {
    print('Error: $e');
  }
}
