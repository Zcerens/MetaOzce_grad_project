import 'package:flutter/material.dart';
import 'package:metaozce/components/background.dart';
import 'package:metaozce/pages/FilterPage/component/filterpage_view.dart';


class FilterPageScreen extends StatelessWidget {
  const FilterPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Background(
      title: "Fair - Price",
      child:FilteredPageView(),
    );
  }
}
