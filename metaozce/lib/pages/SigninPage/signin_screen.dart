
import 'package:flutter/material.dart';
import 'package:metaozce/components/background.dart';
import 'package:metaozce/components/backgroundinit.dart';
import 'dart:convert';

import 'components/signin_view.dart';


class SigninScreen extends StatefulWidget {
  @override
  State<SigninScreen> createState() => _SinginScreenState();
}

class _SinginScreenState extends State<SigninScreen> {
 // const LoginScreen({Key? key}) : super(key: key);
  List<dynamic> allParametreEtiketListesi = [];



  @override
  Widget build(BuildContext context) {
    return BackgroundInit(              
                child: SigninView(),
              );
  }
}
