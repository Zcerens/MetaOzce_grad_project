import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metaozce/const/constant.dart';

import 'package:metaozce/pages/SignupPage/signup_screen.dart';
import 'package:metaozce/widgets/navigationBar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'package:dio/dio.dart';
class SigninView extends StatefulWidget {
   SigninView({Key? key}) : super(key: key);

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  final TextEditingController controller = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  bool isLogin =
      false; //giriş yapınca true olacak, dbye gönderilecek, öbür sayfalarda dbden çekilecek
  bool hidePassword = true;
  String? username = "";
  String? password = "";
  final _controller = TextEditingController();
  final Dio _dio = Dio();
  Future<dynamic> getHotelById(int id) async {
                      try {
                        final response = await _dio.get(
                          'http://80.253.246.51:8080/hotel/$id',
                        );
                        final responseData = response.data;
                        print(responseData["id"]);

                        print(responseData["otelAd"]);
                        print(responseData["fiyat"]);
                        return responseData;
                      } catch (error) {
                        print('Error fetching hotel with ID : $error'); // Hata mesajını yazdır
                        throw Exception('Failed to get hotel with ID: $error');
                      }
                    }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(
            child: Form(
          key: formKey,
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(left: 45, right: 45, bottom: 20, top: 50),
                child: Column(
                  children: [
                    SizedBox(
                      height: defaultPadding,
                    ),
                    Text(
                      "HELLO SIGN IN",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 30),
                      textAlign: TextAlign.center, // Metni ortala
                    ),
                    SizedBox(
                      height: defaultPadding * 10,
                    ),
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(8, 30, 8, 8),
                        child: Column(
                          children: [
                            buildUsername(),
                            const SizedBox(height: defaultPadding),
                            buildPassword(),
                            const SizedBox(height: defaultPadding),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: EdgeInsets.only(right: 16, bottom: 35),
                                child: RichText(
                                  text: TextSpan(
                                      style: TextStyle(
                                          color: textColorMid, fontSize: 15),
                                      children: [
                                        TextSpan(
                                          text: "Forgot password?",
                                          style: TextStyle(
                                            color: kPrimaryColor,
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                            ),
                            const SizedBox(height: defaultPadding * 8),
                            buildLogin(),
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
                                        TextSpan(text: "Don't have account?"),
                                        TextSpan(
                                            text: " " + "Signup",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: kPrimaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            SignupScreen()));
                                              })
                                      ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  bool _isButtonDisabled = false;

  Widget buildLogin() => Builder(
        builder: (context) => SizedBox(
          width: double.infinity, // Genişlik ayarı
          child: ElevatedButton(
            onPressed: _isButtonDisabled
                ? null
                : () {
                    setState(() {

                      _isButtonDisabled = true;
                     getHotelById(1);

                      
                    });

                    final Timer timer = Timer(Duration(seconds: 1), () {
                      setState(() {
                        _isButtonDisabled = false;
                      });
                    });

                    final isValid = formKey.currentState!.validate();
                    if (isValid && flagPassword && flagUsername) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavigationBarMy(),
                        ),
                      ).then((value) {
                        timer.cancel();
                        setState(() {
                          _isButtonDisabled = false;
                        });
                      });
                      ;
                    } else if (!flagUsername) {
                      Fluttertoast.showToast(
                          fontSize: 15,
                          toastLength: Toast.LENGTH_LONG,
                          msg: "Username cannot be empty.",
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red);
                    } else if (!flagPassword) {
                      Fluttertoast.showToast(
                          fontSize: 15,
                          toastLength: Toast.LENGTH_LONG,
                          msg: "Password cannot be empty.",
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red);
                    } else {}
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
            child: Text("SIGN IN",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20)),
          ),
        ),
      );

  bool flagUsername = false;
  Widget buildUsername() => TextFormField(
        decoration: InputDecoration(
          // labelText: 'Username',
          hintText: "Username",
          suffixIcon: flagUsername ? Icon(Icons.check, color: iconColor) : null,
          icon: Icon(Icons.person),
          fillColor: Colors.transparent,
          filled: true,
          focusedBorder: UnderlineInputBorder(
            borderSide: flagUsername
                ? BorderSide(color: kPrimaryColor)
                : BorderSide(color: grey),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: flagUsername
                ? BorderSide(color: kPrimaryColor)
                : BorderSide(color: grey),
          ),
        ),
        style: TextStyle(
          color: flagUsername ? kPrimaryColor : grey,
        ),
        maxLength: 30,
        onChanged: (value) {
          setState(() {
            if (value!.length < 1) {
              flagUsername = false;
            } else {
              flagUsername = true;
            }
            username = value;
          });
        },
      );

  bool flagPassword = false;
  Widget buildPassword() => TextFormField(
        controller: _controller,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                hidePassword = !hidePassword;
              });
            },
            icon: Icon(
              hidePassword ? Icons.visibility_off : Icons.visibility,
              color: hidePassword ? grey : kPrimaryColor,
            ),
          ),
          //   labelText: 'Password',
          hintText: "Password",
          icon: Icon(Icons.lock),
          fillColor: Colors.transparent,
          filled: true,
          focusedBorder: UnderlineInputBorder(
            borderSide: flagPassword
                ? BorderSide(color: kPrimaryColor)
                : BorderSide(color: grey),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: flagPassword
                ? BorderSide(color: kPrimaryColor)
                : BorderSide(color: grey),
          ),
          border: InputBorder.none, // Çerçeve yok
        ),
        style: TextStyle(
          color: flagPassword
              ? Color.fromARGB(255, 9, 129, 228)
              : Color.fromARGB(255, 168, 168, 168),
        ),
        maxLength: 20,
        onChanged: (value) {
          setState(() {
            if (value!.length < 1) {
              flagPassword = false;
            } else {
              flagPassword = true;
            }
            password = _controller.text;
          });
        },
        keyboardType: TextInputType.visiblePassword,
        obscureText: hidePassword,
      );
}
