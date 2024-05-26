
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:metaozce/pages/DetailPage/detail_screen.dart';
import 'package:metaozce/service/detail_service.dart';

class SearchItem extends StatefulWidget {
  const SearchItem({
    Key? key,
    required this.hotel_id,
  }) : super(key: key);

  final int hotel_id;

  @override
  State<SearchItem> createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> { 
    final Dio _dio = Dio();
   Future<dynamic> getHotelById(int id) async {
                      try {
                        final response = await _dio.get(
                          'http://80.253.246.51:8080/hotel/$id',
                        );
                        final responseData = response.data;
                        print(responseData["id"]);

                        print(responseData["otelAd"]);
                        print(responseData["fiyat"]);
                        return responseData;
                      } catch (error) {
                        print('Error fetching hotel with ID : $error'); // Hata mesajını yazdır
                        throw Exception('Failed to get hotel with ID: $error');
                      }
                    }


  @override
  Widget build(BuildContext context) {
    var data= getHotelById(widget.hotel_id);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailScreen(data: widget.hotel_id)),
        );
      },
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(data.toString()),
          ),
          title: Text(data.toString()),
          subtitle: Text(data.toString()),
        ),
      ),
    );
  }
}
