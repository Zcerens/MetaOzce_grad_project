import 'package:flutter/material.dart';
import 'package:metaozce/pages/FilterPage/filterpage_screen.dart';
import 'package:metaozce/pages/MyHotelsPage/components/my_hotels_view.dart';
import 'package:metaozce/pages/MyHotelsPage/my_hotels_screen.dart';

import 'package:metaozce/pages/SignupPage/signup_screen.dart';
import 'package:metaozce/const/constant.dart';
import 'package:metaozce/pages/HomePage/components/home_view.dart';


import 'entity/profile_menu.dart';
import 'entity/profile_pic.dart';

class ProfileScreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Account",
            icon: Icon(
              Icons.person,
               color: kPrimaryColor,
            ),
            press: () => {},
          ),
          ProfileMenu(
            text: "Favorite Hotels",
            icon: Icon(Icons.hotel,  color: kPrimaryColor,),
            
            press: () {Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyHotelsScreen()));
                },
          ),
          // ProfileMenu(
          //   text: "Motification",
          //   icon: Icon(Icons.notifications,  color: kPrimaryColor,),
            
          //   press: () {},
          // ),
          // ProfileMenu(
          //   text: "Settings",
          //   icon: Icon(Icons.settings,  color: kPrimaryColor,),
          //   press: () {},
          // ),
          ProfileMenu(
            text: "Fair-Price",
            icon: Icon(Icons.money,  color: kPrimaryColor,),
            press: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => FilterPageScreen())),
          ),
          ProfileMenu(
            text: "Logout",
            icon: Icon(Icons.logout,  color: kPrimaryColor,),
            press: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignupScreen())),
          ),
        ],
      ),
    );
  }
}
