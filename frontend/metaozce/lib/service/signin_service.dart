import 'package:dio/dio.dart';
import 'package:metaozce/entity/User.dart';

class SigninService {
  final Dio _dio = Dio();

  Future<Response> loginUser(String username, String password) async {
    try {
      final response = await _dio.get(
        'http://80.253.246.51:8080/user/login?username=$username&password=$password',
        //data: user.toJson(), // User sınıfında toJson() metodu olmalıdır
      );
     
      return response;
    } catch (error) {
      throw Exception('Failed to create user: $error');
    }
  }
}

void main() async {
  final SigninService signinService = SigninService();

  // HotelService'deki getHotelWithId metodunu çağırarak bir otel al
  try {
    final userData = await signinService.loginUser("demouser", "demopass");

    print('User Data: $userData');
  } catch (e) {
    print('Error: $e');
  }
}