import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:metaozce/const/constant.dart';
import 'package:metaozce/pages/DetailPage/detail_screen.dart';
import 'package:metaozce/pages/HomePage/components/widgets/color.dart';
import 'package:metaozce/pages/HomePage/components/widgets/custom_image.dart';
import 'package:metaozce/widgets/rating.dart';

class FeatureItemForFilter extends StatelessWidget {
  const FeatureItemForFilter({
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
          MaterialPageRoute(
              builder: (context) => DetailScreen(
                  data: data[
                      "id"])), // DetailPage'e veri geçmek için 'data' parametresini kullandım
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
    String originalString = data['fiyat'];
    String numericString =
        originalString.replaceAll(RegExp(r'[^\d]'), ''); // Virgülü kaldır
    double numericValue = double.parse(numericString) /
        100; // Sayısal değeri elde et ve 100'e böl
    String formattedValue =
        NumberFormat("#,##0.00", "en_US").format(numericValue); // Biçimlendir
         MaterialColor percantage_color;
         data['fair_price_percentage'] > 0 ? percantage_color = Colors.green:  percantage_color = Colors.red;
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (data["score"] != null && data["score"].isNotEmpty)
          Row(
            children: [
              Icon(
                Icons.star,
                size: 14,
                color: AppColor.yellow,
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                data["score"] ?? "", // null kontrolü
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "AI: ${NumberFormat("#,##0.00", "en_US").format(data["predicted_price"])} TL",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: const Color.fromARGB(255, 30, 100, 32),
                ),
              ),
              Text(
                "Website: ${formattedValue} TL",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 124, 124, 124),
                ),
              ),
               Text(
               
                " ${data['fair_price_range']} TL",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: percantage_color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImage(BuildContext context) {
    return CustomImage(
      data["imageurl"] == null
          ? "https://images.unsplash.com/photo-1598928636135-d146006ff4be?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTF8fGZhc2hpb258ZW58MHx8MHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60"
          : data["imageurl"],
      radius: 15,
      height: MediaQuery.of(context).size.width * 0.2,
    );
  }
}
