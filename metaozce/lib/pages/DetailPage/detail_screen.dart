import 'package:flutter/material.dart';
import 'package:metaozce/components/background.dart';
import 'package:metaozce/pages/DetailPage/components/detail_view.dart';
import 'package:metaozce/pages/MyHotelsPage/components/my_hotels.dart';


class DetailScreen extends StatelessWidget {
  const DetailScreen({  Key? key,
    required this.data,
  }) : super(key: key);
    final data;

  @override
  Widget build(BuildContext context) {
    return Background(
      title: "Hotel's Detail",
      child: DetailView(data: data,),
    );
  }
}
