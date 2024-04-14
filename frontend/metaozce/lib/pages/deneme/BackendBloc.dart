import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class BackendBloc extends Cubit<String> {
  BackendBloc() : super('');

  Future<String> fetchData() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5000/onerilen-oteller/adam%20ev'));
    if (response.statusCode == 200) {
      emit(response.body);
      print(response.body);
      return response.body;
    } else {
      
      emit('Failed to fetch data');
      return "hata";
    }
  }
}