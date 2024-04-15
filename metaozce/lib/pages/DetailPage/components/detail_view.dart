import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:metaozce/const/constant.dart';
import 'package:metaozce/pages/DetailPage/components/widgets/detail_item.dart';

class DetailView extends StatelessWidget {
  final Map<String, dynamic> data;

  const DetailView({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailItem(data: data),
        
             _buildHotelDetail(context)
           
             
             
               
              
          
          ],
        ),
      ),
    );
  }

  _buildHotelDetail(BuildContext context) {
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
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.width * 0.4,
              child: Card(
                color: Colors.white,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Type: ${data["type"]}',
                        style: TextStyle(fontSize: 15.0),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Rate: ${data["rate"]}',
                        style: TextStyle(fontSize: 15.0),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Price: ${data["price"]}',
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
