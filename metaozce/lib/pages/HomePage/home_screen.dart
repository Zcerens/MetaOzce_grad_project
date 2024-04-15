import 'package:flutter/material.dart';
import 'package:metaozce/components/background.dart';
import 'package:metaozce/pages/HomePage/components/home_view.dart';




class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Background(
      title: "Home",
      child: HomeView(),
    );
  }
}