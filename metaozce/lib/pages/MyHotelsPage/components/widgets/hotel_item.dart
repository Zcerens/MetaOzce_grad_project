import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:metaozce/const/constant.dart';
import 'package:metaozce/pages/DetailPage/detail_screen.dart';
import 'package:metaozce/service/hotel_user_history_service.dart';

class HotelItem extends StatelessWidget {
  final data;
  final VoidCallback
      refreshMyHotels; // MyHotelsView widgetini yeniden yüklemek için callback
  final userId;

  const HotelItem(
      {Key? key,
      required this.data,
      required this.refreshMyHotels,
      required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailScreen(
                    data: data[
                        "id"]))); // DetailPage'e veri geçmek için 'data' parametresini kullandım
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(data['hotel']['imageurl']),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['hotel']['otelAd'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: kPrimaryColor2,
                              size: 16,
                            ),
                            SizedBox(width: 5),
                            Text(
                              data['hotel']['bolge'],
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      final HotelUserHistoryService hotelUserHistoryService =
                          HotelUserHistoryService();
                      try {
                        final hotelData =
                            await hotelUserHistoryService.deleteHotelHistory(
                                int.parse(userId), data['id']); //TODO user id
                        Fluttertoast.showToast(
                            msg: "Hotel deleted from user history",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        //print('Hotel Data: $hotelData');

                        // Silme işlemi tamamlandıktan sonra callback'i çağır
                        refreshMyHotels();
                      } catch (e) {
                        Fluttertoast.showToast(
                            msg: "Hotel cannot delete from user history",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        print('Error: $e');
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 129, 9, 1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        Icons.delete_forever,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
