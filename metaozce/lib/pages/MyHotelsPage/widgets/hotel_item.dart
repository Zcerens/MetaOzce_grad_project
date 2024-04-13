import 'package:flutter/material.dart';

class HotelItem extends StatelessWidget {
  final String name;
  final String address;
  final String rating;
  final String imageUrl;

  const HotelItem({
    Key? key,
    required this.name,
    required this.address,
    required this.rating,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        title: Text(name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(address),
            Row(
              children: [
                Icon(Icons.star, color: Colors.yellow),
                Text(rating.toString()),
              ],
            ),
          ],
        ),
        onTap: () {
          // Oteli seçme işlevi eklenebilir
        },
      ),
    );
  }
}