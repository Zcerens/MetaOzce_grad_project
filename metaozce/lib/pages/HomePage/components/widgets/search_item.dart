
import 'package:flutter/material.dart';
import 'package:metaozce/pages/DetailPage/detail_screen.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({
    Key? key,
    required this.hotel,
  }) : super(key: key);

  final Map<String, dynamic> hotel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailScreen(data: hotel)),
        );
      },
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(hotel["image"]),
          ),
          title: Text(hotel["name"]),
          subtitle: Text(hotel["location"]),
        ),
      ),
    );
  }
}
