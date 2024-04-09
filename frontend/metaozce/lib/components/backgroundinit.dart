import 'package:metaozce/const/constant.dart';
import 'package:flutter/material.dart';

class BackgroundInit extends StatelessWidget {
  final Widget child;
 
    BackgroundInit({
    Key? key,
    required this.child,
    
    this.topImage = "assets/background1.png",
    this.bottomImage = "assets/background1.png",
  }) : super(key: key);

  final String topImage, bottomImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      // bottomNavigationBar:
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Positioned(
            top: MediaQuery.of(context).size.height * 0,
            child: Image.asset(
              bottomImage,
            ),
            width: MediaQuery.of(context).size.width * 1,
          ),
          SafeArea(child: child),
        ],
      ),
    );
  }
}
