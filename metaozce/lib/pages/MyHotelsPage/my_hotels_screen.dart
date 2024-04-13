import 'package:flutter/material.dart';
import 'package:metaozce/components/background.dart';
import 'package:metaozce/pages/MyHotelsPage/my_hotels.dart';


class MyHotelsScreen extends StatelessWidget {
  const MyHotelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Background(
      title: "My Hotels",
      child: MyHotelsPage(),
    );
  }
}
