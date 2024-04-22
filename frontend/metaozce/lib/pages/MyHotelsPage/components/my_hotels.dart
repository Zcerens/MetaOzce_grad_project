import 'package:flutter/material.dart';

import 'package:metaozce/const/constant.dart';

import 'package:metaozce/pages/HomePage/components/widgets/data.dart';
import 'package:metaozce/pages/MyHotelsPage/widgets/hotel_item.dart'; // Renkleri içe aktardık

class MyHotelsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        _buildSearchBar(context)
        ,
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: recommends.length, // Otellerin sayısı
              itemBuilder: (context, index) {
                final hotel = recommends[index];
                return HotelItem(
                  name: hotel['name'],
                  address: hotel['price'],
                  rating: hotel['rate'],
                  imageUrl: hotel['image'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


Widget _buildSearchBar(BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
    height: MediaQuery.of(context).size.width * 0.1, // Arama çubuğunun yüksekliği
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0), // Köşelerin yuvarlanma yarıçapı
      border: Border.all(color: Colors.grey), // Kenar çizgisi rengi ve kalınlığı
    ),
    child: Theme(
      data: ThemeData(
        // Arama çubuğunun arka plan rengini sıfıra ayarla
        primaryColor: Colors.transparent,
        hintColor: Colors.transparent,
      ),
      child: const TextField(
        cursorColor: Colors.black, // Metin imlecinin rengi
        decoration: InputDecoration(
          hintText: "Add Hotel",
          hintStyle: TextStyle(color: Colors.black87, fontSize: 14.0, fontWeight: FontWeight.w500), // Placeholder metin stili
          prefixIcon: Icon(Icons.search, color: iconColor), // Arama simgesi rengi
          border: InputBorder.none, // Kenar çizgisini kaldır
          contentPadding: EdgeInsets.symmetric(horizontal: 15.0), // İçerik dolgusu
        ),
      ),
    ),
  );
}