
import 'package:flutter/material.dart';
import 'package:metaozce/components/backgroundinit.dart';
import 'package:metaozce/pages/WelcomePage/component/welcome_view.dart';



class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
 // const LoginScreen({Key? key}) : super(key: key);
  List<dynamic> allParametreEtiketListesi = [];



  @override
  Widget build(BuildContext context) {
    return BackgroundInit(
              child: WelcomeView(),
              );
  }
}
