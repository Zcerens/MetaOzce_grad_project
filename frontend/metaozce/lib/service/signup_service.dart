import 'package:dio/dio.dart';
import 'package:metaozce/entity/User.dart';

class SignupService {
  final Dio _dio = Dio();

  Future<Response> createUser(User user) async {
    try {
      final response = await _dio.post(
        'http://80.253.246.51:8080/user/create',
        data: user.toJson(), // User sınıfında toJson() metodu olmalıdır
      );
      return response;
    } catch (error) {
      throw Exception('Failed to create user: $error');
    }
  }
}


