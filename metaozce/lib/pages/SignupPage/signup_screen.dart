
import 'package:flutter/material.dart';
import 'package:metaozce/components/backgroundinit.dart';
import 'dart:convert';

import 'package:metaozce/pages/SignupPage/component/signup_view.dart';



class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
 // const LoginScreen({Key? key}) : super(key: key);
  List<dynamic> allParametreEtiketListesi = [];



  @override
  Widget build(BuildContext context) {
    return BackgroundInit(
              child: SignupView(),
              );
  }
}
