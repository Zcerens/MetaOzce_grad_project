import 'package:dio/dio.dart';
import 'package:metaozce/entity/Hotel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HotelService {
  final Dio _dio = Dio();

  List <dynamic> hotels =[];

 Future<List<dynamic>> getHotelAll({String? feature, int? number}) async {
  try {
   
    String numberStr=number.toString();
    
    String url = 'http://80.253.246.51:8080/hotel/get';
    if(feature == null ){
      url='http://80.253.246.51:8080/hotel/get';
    }
    else if (feature != null && number != null) {
      url += '?feature=$feature&numberStr=$numberStr';
    } else if (feature != null) {
      url += '?feature=$feature';
    } else if (number != null) {
      url += '?number=$number';
    }

    final response = await _dio.get(url);
    final responseData = response.data;
    hotels = responseData;


    return hotels;
  } catch (error) {
    print('Error fetching getHotelAll : $error'); 
    throw Exception('Failed to getHotelAll: $error');
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
    print('Error hotelService: $e');
  }
}
