import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:metaozce/const/constant.dart';
import 'package:metaozce/pages/DetailPage/components/widgets/detail_item.dart';
import 'package:metaozce/service/detail_service.dart';

class DetailView extends StatefulWidget {
  final int data;

  const DetailView({Key? key, required this.data}) : super(key: key);

  @override
  _DetailView createState() => _DetailView();
}

class _DetailView extends State<DetailView> {
  int _currentIndex = 0;
  final DetailService _detailService = DetailService();
  var responseData;

  @override
  void initState() {
    super.initState();
    fetchHotelDetail();
  }

  fetchHotelDetail() async {
    try {
      final hotelData = await _detailService.getHotelById(widget.data);
      setState(() {
        responseData = hotelData;
      });
      print('Hotel Data: $hotelData');
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return  responseData == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailItem(data: responseData),
                  _buildHotelDetail(context, responseData),
                     buildButton(),
                ],
             
              ),
            );
    
  }

  Widget _buildHotelDetail(BuildContext context, dynamic responseData) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Expanded(child: Divider(color: kPrimaryBackColor)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Details",
                  selectionColor: Color.fromARGB(255, 87, 87, 87),
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(child: Divider(color: kPrimaryBackColor)),
            ],
          ),
          SizedBox(height: 10),
          CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.width * 0.5,
              viewportFraction: 0.9,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: [
           
            _buildDetailBox(
  context,
  'Distance to Airport: ${responseData["hava_alanina_uzakligi"]}',
  'Distance to Sea: ${responseData["denize_uzakligi"]}',
  'Pier: ${responseData["iskele"] == 0 ? 'None' : 'Available'} ',
  'Beach: ${responseData["plaj"]}',
  'Elevator: ${responseData["asansor"] == 0 ? 'None' : 'Available'} ',
),

_buildDetailBox(
  context,
  'A la Carte Restaurant: ${responseData["a_la_carte_restoran"]} Pieces',                
  'Open Restaurant: ${responseData["acik_restoran"]} Pieces',
  'Closed Restaurant: ${responseData["kapali_restoran"]} Pieces',
  'Open Pool: ${responseData["acik_havuz"]} Pieces',
  'Indoor Pool: ${responseData["kapali_havuz"]} Pieces',
),

_buildDetailBox(
  context,
  'Sauna: ${responseData["sauna"] == 0 ? 'None' : 'Available'} ',
  'Bar: ${responseData["bar"]} Pieces',  
  'Water Slide: ${responseData["su_kaydiragi"] == 0 ? 'None' : 'Available'} ',
  'Ballroom: ${responseData["balo_salonu"] == 0 ? 'None' : 'Available'} ',
  'Hairdresser: ${responseData["kuafor"] == 0 ? 'None' : 'Available'} ',
)

              
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < 3; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: i == _currentIndex ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

Widget _buildDetailBox(
  BuildContext context, String a, String b, String c, String d, String e) {
  return Center(
    child: Container(
      width: MediaQuery.of(context).size.width * 0.9, // Gerekirse genişliği ayarlayın
      child: Card(
        color: Color.fromARGB(255, 253, 255, 255),
        elevation: 10,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: kPrimaryBackColor, width: 2),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              buildRichText(a),
              SizedBox(height: 8), // Boşluk ekledik
              buildRichText(b),
              SizedBox(height: 8), // Boşluk ekledik
              buildRichText(c),
              SizedBox(height: 8), // Boşluk ekledik
              buildRichText(d),
              SizedBox(height: 8), // Boşluk ekledik
              buildRichText(e),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget buildRichText(String text) {
  List<String> parts = text.split(':');
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        parts[0] + ': ',
        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
      ),
      Expanded(
        child: Text(
          parts[1].trim(),
          style: TextStyle(fontSize: 15.0, fontStyle: FontStyle.italic),
          textAlign: TextAlign.right,
        ),
      ),
    ],
  );
}

Widget buildButton() {
  return Align(
    alignment: Alignment.centerRight,
    child: Padding(
      padding: const EdgeInsets.only(right: 16.0), // Sağdan boşluk ekleyelim
      child: TextButton(
        onPressed: () {
          print("visitede eklendi"); // Todo
        },
        style: TextButton.styleFrom(
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
            ),
            SizedBox(width: 15), // Simge ile metin arasına boşluk ekleyelim
            Text(
              "VISITED",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
               fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

}
