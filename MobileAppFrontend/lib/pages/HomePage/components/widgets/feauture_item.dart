import 'package:flutter/material.dart';
import 'package:metaozce/const/constant.dart';
import 'package:metaozce/pages/DetailPage/detail_screen.dart';
import 'package:metaozce/pages/HomePage/components/widgets/color.dart';
import 'package:metaozce/widgets/rating.dart';


import 'custom_image.dart';

class FeautureItem extends StatelessWidget {
  const FeautureItem({
    Key? key,
    required this.data,
    this.onTap,
  }) : super(key: key);

  final data;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailScreen(data: data["id"])), // DetailPage'e veri geçmek için 'data' parametresini kullandım
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Row(
  children: [
    _buildImage(context),
    const SizedBox(
      width: 10,
    ),
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildInfo(),
          _buildRateAndPrice(),
        ],
      ),
    )
  ],
),

      ),
    );
  }

  Widget buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data["otelAd"],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColor.textColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
         Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: kPrimaryColor,
                    size: 16,
                  ),
                  SizedBox(width: 5),
                  Text(
                    data['bolge'],
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
        const SizedBox(
          height: 15,
        ),
       // _buildRateAndPrice(),
      ],
    );
  }

  Widget _buildRateAndPrice() {
return Row(
  children: [
    if (data["score"] != null && data["score"].isNotEmpty)
  Icon( 
          Icons.star,
          size: 14,
          color: AppColor.yellow,
        ),
  


    if (data["score"] != null && data["score"].isNotEmpty)
      SizedBox(
        width: 3,
      ),
    Expanded(
      flex: 2,
      child: Text(
        data["score"] ?? "", // null kontrolü
        style: TextStyle(fontSize: 12, color: Colors.grey),
      ),
    ),
    Text(
        data["fiyat"],
        style: TextStyle(
          
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: Color.fromARGB(255, 58, 58, 58),
        ),
      ),
    
  ],
);

  }

  Widget _buildImage(BuildContext context) {
    return CustomImage(

      data["imageurl"]==null? "https://images.unsplash.com/photo-1598928636135-d146006ff4be?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fGZhc2hpb258ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60":data["imageurl"],
      radius: 15,
      height: MediaQuery.of(context).size.width * 0.2,
    );
  }
}