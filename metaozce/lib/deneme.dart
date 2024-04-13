import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Önerilen Oteller',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OtelListesi(),
    );
  }
}

class OtelListesi extends StatefulWidget {
  @override
  _OtelListesiState createState() => _OtelListesiState();
}

class _OtelListesiState extends State<OtelListesi> {
  List<String> onerilenOteller = [];

  Future<void> fetchOnerilenOteller(String oncekiOtelAd) async {
    
   final response = await http.get(Uri.parse('http://127.0.0.1:5000/onerilen-oteller/$oncekiOtelAd'));

    print(response);
   if (response.statusCode == 200) {
  setState(() {
    onerilenOteller = List<String>.from(jsonDecode(response.body));
  });
} else {
  // İsteğin başarısız olduğunda kullanıcıya bir geri bildirim göstermek için bir işlem yapabilirsiniz.
  print('Failed to load recommended hotels. Status code: ${response.statusCode}');
}


  //   http.get(Uri.parse('http://127.0.0.1:54792/onerilen-oteller/$oncekiOtelAd')).then((response)=>
  //    onerilenOteller = List<String>.from(jsonDecode(response.body))).catchError((error) => print(error));
  }

  @override
  void initState() {
    fetchOnerilenOteller('Adam Eve'); // Örnek olarak
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Önerilen Oteller'),
      ),
      body: onerilenOteller.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: onerilenOteller.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(onerilenOteller[index]),
                );
              },
            ),
    );
  }
}
