import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:metaozce/const/constant.dart';
import 'package:metaozce/pages/DetailPage/components/widgets/detail_item.dart';
import 'package:metaozce/service/detail_service.dart';

class DetailView extends StatefulWidget {
  final Map<String, dynamic> data;

  const DetailView({Key? key, required this.data}) : super(key: key);

  @override
  _DetailView createState() => _DetailView();
}

class _DetailView extends State<DetailView> {
  int _currentIndex = 0;
  final DetailService _detailService = DetailService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _detailService.getHotelWithId(2),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Veri başarıyla alındı
            final responseData = snapshot.data;
          
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 // DetailItem(data:responseData), // widget.data yerine responseData kullanılmalı
                  _buildHotelDetail(context),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildHotelDetail(BuildContext context) {
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
                  "Extra Details",
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
                  'Type: ${widget.data["type"]}',
                  'Rate: ${widget.data["rate"]}',
                  'Price: ${widget.data["price"]}'),
              _buildDetailBox(
                  context,
                  'Type: ${widget.data["type"]}',
                  'Rate: ${widget.data["rate"]}',
                  'Price: ${widget.data["price"]}'),
              _buildDetailBox(
                  context,
                  'Type: ${widget.data["type"]}',
                  'Rate: ${widget.data["rate"]}',
                  'Price: ${widget.data["price"]}'),
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
      BuildContext context, String type, String rate, String price) {
    return Center(
      child: Container(
        width:
            MediaQuery.of(context).size.width * 0.9, // Adjust width as needed
        child: Card(
          color: Colors.white,
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
                Text(
                  type,
                  style: TextStyle(fontSize: 15.0),
                ),
                SizedBox(height: 5),
                Text(
                  rate,
                  style: TextStyle(fontSize: 15.0),
                ),
                SizedBox(height: 5),
                Text(
                  price,
                  style: TextStyle(fontSize: 15.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
