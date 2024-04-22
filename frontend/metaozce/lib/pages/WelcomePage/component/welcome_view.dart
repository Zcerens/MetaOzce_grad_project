import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:metaozce/const/constant.dart';

import 'package:metaozce/pages/SigninPage/signin_screen.dart';
import 'package:metaozce/pages/SignupPage/signup_screen.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView (
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
            ),
            
          ),
          Padding(
            padding:
                EdgeInsets.only(left: 45, right: 45, top: 40),
            child: Column(
              children: [
               
                Text(
                  "WELCOME",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 30),
                  textAlign: TextAlign.center, // Metni ortala
                ),
                SizedBox(
                  height: defaultPadding * 11,
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 100), 
                  child: Column(
                    
                    children: [
                      buildSignin(),
                      const SizedBox(height: defaultPadding),
                      buildSignup(),
                      const SizedBox(height: defaultPadding),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(right: 0),
                          child: RichText(
                            text: TextSpan(
                                style: TextStyle(
                                    color: textColorMid, fontSize: 14),
                                children: [
                                  //todo buraya logolar gelecek gmail vs.
                                ]),
                          ),
                        ),
                      ),
                      const SizedBox(height: defaultPadding * 10),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(right: 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                      color: textColorMid, fontSize: 17),
                                  children: [
                                    TextSpan(
                                        text: "Login with Social Media"),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  height:
                                      8), // Boşluk ekleyerek logoları metinden ayırıyoruz
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize
                                    .min, // Row'un en küçük boyutu almasını sağlar
                                children: [
                                  SignInButton(
                                    Buttons.Email,
                                    mini: true,
                                    onPressed: () {},
                                  ),
                                  Divider(),
                                  SignInButton(
                                    Buttons.Facebook,
                                    mini: true,
                                    onPressed: () {},
                                  ),
                                  Divider(),
                                  SignInButton(
                                    Buttons.Twitter,
                                    mini: true,
                                    onPressed: () {},
                                  ),
                                  Divider(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSignin() => Builder(
        builder: (context) => SizedBox(
          width: double.infinity, // Genişlik ayarı
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SigninScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              // Butonun iç rengini şeffaf yapın
              backgroundColor: Colors.white, // Yazı rengi
              textStyle: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.045,
              ),
              elevation: 4, // Butonun yüksekliği

              padding:
                  EdgeInsets.symmetric(vertical: 16), // Buton iç içe boşluk
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    50), // Buton köşelerinin yuvarlanma derecesi
                side: BorderSide(
                    color: kPrimaryColor,
                    width: 2), // Dış çerçeve rengi ve kalınlığı
              ),
              minimumSize: Size(double.infinity, 50), // Butonun minimum boyutu
              tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Basılma boyutu
              animationDuration:
                  Duration(milliseconds: 300), // Animasyon süresi
              // Butona basıldığında ara rengin belirlenmesi
            ),
            child: Text(
              "SIGN IN",
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ),
        ),
      );

  Widget buildSignup() => Builder(
        builder: (context) => SizedBox(
          width: double.infinity, // Genişlik ayarı
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignupScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor, // Buton rengi
              textStyle: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.045,
              ),
              elevation: 4, // Butonun yüksekliği
              shadowColor: Colors.grey, // Gölgelenme rengi
              padding:
                  EdgeInsets.symmetric(vertical: 16), // Buton iç içe boşluk
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    50), // Buton köşelerinin yuvarlanma derecesi
              ),
              minimumSize: Size(double.infinity, 50), // Butonun minimum boyutu
              tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Basılma boyutu
              animationDuration:
                  Duration(milliseconds: 300), // Animasyon süresi
              // Butona basıldığında ara rengin belirlenmesi
            ),
            child: Text("SIGN UP",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20)),
          ),
        ),
      );
}
