import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:flutter/material.dart';
import 'package:metaozce/const/constant.dart';
import 'package:metaozce/pages/FilterPage/filterpage_screen.dart';

import 'package:metaozce/pages/ProfilePage/components/profile_view.dart';
import 'package:metaozce/pages/ProfilePage/profile_screen.dart';

import 'package:metaozce/pages/SigninPage/signin_screen.dart';
import 'package:metaozce/pages/HomePage/components/home_view.dart';



  class NavigationBarMy extends StatefulWidget {
  int index;
  String? username_u;

  NavigationBarMy({
    this.index = 0,
  });

  @override
  _NavigationBarMyState createState() => _NavigationBarMyState();
}

class _NavigationBarMyState extends State<NavigationBarMy> {
  @override
  void initState() {
    super.initState();
  }

  // bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    final screens = [
      HomeView(),

      ProfileScreen(),
      
    ];
    return Scaffold(
      body: screens[widget.index],
      bottomNavigationBar: CurvedNavigationBar(
          index: widget.index,
          backgroundColor: kPrimaryBackColor,
          color: kPrimaryColor,
          animationDuration: const Duration(milliseconds: 300),
          onTap: (index) => setState(() {
                widget.index = index;
              }),
          items: [
            Icon(
              Icons.home,
              color: Colors.white,
              //size: 50,
            ),
           
            Visibility(
              visible: true,
              child: Icon(
                Icons.person,
                color: Colors.white,
               // size: 50,
              ),
            )
          ]),
    );
  }
}