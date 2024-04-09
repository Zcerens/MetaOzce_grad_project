import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metaozce/const/constant.dart';
import 'package:metaozce/pages/HomePage/home_screen.dart';
import 'package:metaozce/pages/SigninPage/signin_screen.dart';
import 'package:metaozce/pages/SignupPage/signup_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController controller = TextEditingController();
  bool flagFullname = false;
  bool flagUsername = false;
  bool flagPassword = false;
  bool flagPasswordAgain = false;
  final formKey = GlobalKey<FormState>();
  final TextEditingController controllerFullname = TextEditingController();
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final controllerPasswordAgain = TextEditingController();
  bool isLogin =
      false; //giriş yapınca true olacak, dbye gönderilecek, öbür sayfalarda dbden çekilecek
  bool hidePassword = true;
  bool hidePasswordAgain = true;
void showToast(String message, Color backgroundColor) {
  Fluttertoast.showToast(
    fontSize: 15,
    toastLength: Toast.LENGTH_LONG,
    msg: message,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: backgroundColor,
  );
}
void checkFlagsAndShowToast() {
  if (!flagFullname) {
    showToast("Fullname can't be shorter than 5 characters.", Colors.red);
  } else if (!flagUsername) {
    showToast("Username can't be shorter than 5 characters.", Colors.red);
  } else if (!flagPassword) {
    showToast("Password can't be shorter than 7 characters.", Colors.red);
  } else if (!flagPasswordAgain) {
    showToast("Password Again can't be shorter than 7 characters.", Colors.red);
  } else if (controllerPassword.text != controllerPasswordAgain.text) {
    showToast("Passwords do not match.", Colors.red);
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
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 8,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
              ),
              /*  Image.asset(
                              "assets/logo/logodhp2.PNG",
                              width: 200,
                            ),*/
              Padding(
                padding:
                    EdgeInsets.only(left: 45, right: 45, bottom: 20, top: 30),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "HELLO SIGN UP",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 30),
                      textAlign: TextAlign.center, // Metni ortala
                    ),
                    SizedBox(
                      height: defaultPadding * 11,
                    ),
                    buildFullname(),
                    const SizedBox(height: defaultPadding),
                    buildUsername(),
                    const SizedBox(height: defaultPadding),
                    buildPassword(),
                    const SizedBox(height: defaultPadding),
                    buildPasswordAgain(),
                    const SizedBox(height: defaultPadding),
                    const SizedBox(height: defaultPadding * 2),
                    buildLogin(),
                    const SizedBox(height: defaultPadding),
                    Center(//todo logolar buraya da gelebilir
                        ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(right: 0),
                        child: RichText(
                          text: TextSpan(
                              style:
                                  TextStyle(color: textColorMid, fontSize: 14),
                              children: [
                                //todo buraya logolar gelecek gmail vs.
                              ]),
                        ),
                      ),
                    ),
                    const SizedBox(height: defaultPadding * 0.1),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(right: 0),
                        child: RichText(
                          text: TextSpan(
                              style:
                                  TextStyle(color: textColorMid, fontSize: 14),
                              children: [
                                TextSpan(text: "Already have account?"),
                                TextSpan(
                                    text: " " + "Sign in",
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
                                                    SigninScreen()));
                                      })
                              ]),
                        ),
                      ),
                    ),
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
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _isButtonDisabled
                ? null
                : () {
                    setState(() {
                      _isButtonDisabled = true;
                    });

                    final Timer timer = Timer(Duration(seconds: 1), () {
                      setState(() {
                        _isButtonDisabled = false;
                      });
                    });

                    final isValid = formKey.currentState!.validate();
                    if (flagFullname &&
                        flagPasswordAgain &&
                        flagPassword &&
                        isValid) {
                      Fluttertoast.showToast(
                          fontSize: 15,
                          toastLength: Toast.LENGTH_LONG,
                          msg: "Kayıt başarılır",
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.green);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SigninScreen()),
                      ).then((value) {
                        timer.cancel();
                        setState(() {
                          _isButtonDisabled = false;
                        });
                      });
                    } 
                    else {
                       checkFlagsAndShowToast();
                    }
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: _isButtonDisabled ? Colors.grey : kPrimaryColor,
              textStyle: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.045,
              ),
              elevation: 4,
              shadowColor: Colors.grey,
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              minimumSize: Size(double.infinity, 50),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              animationDuration: Duration(milliseconds: 300),
            ),
            child: Text(
              "SIGN UP",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ),
        ),
      );

  Widget buildFullname() => TextFormField(
        controller: controllerFullname,
        decoration: InputDecoration(
          // labelText: 'Username',
          hintText: "Full Name",
          suffixIcon: flagFullname ? Icon(Icons.check, color: iconColor) : null,
          icon: Icon(Icons.person),
          fillColor: Colors.transparent,
          filled: true,
          focusedBorder: UnderlineInputBorder(
            borderSide: flagFullname
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
          color: flagFullname ? kPrimaryColor : grey,
        ),
        maxLength: 30,
        onChanged: (value) {
          setState(() {
            if (value!.length < 5) {
              flagFullname = false;
            } else {
              flagFullname = true;
            }
          });
        },
      );

  Widget buildUsername() => TextFormField(
        controller: controllerUsername,
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
            if (value!.length < 5) {
              flagUsername = false;
            } else {
              flagUsername = true;
            }
          });
        },
      );

  Widget buildPassword() => TextFormField(
        controller: controllerPassword,
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
              ? kPrimaryColor
              : grey,
        ),
        maxLength: 20,
        onChanged: (value) {
          setState(() {
            if (value!.length < 7) {
              flagPassword = false;
            } else {
              flagPassword = true;
            }
          });
        },
        keyboardType: TextInputType.visiblePassword,
        obscureText: hidePassword,
      );

  Widget buildPasswordAgain() => TextFormField(
        controller: controllerPasswordAgain,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                hidePasswordAgain = !hidePasswordAgain;
              });
            },
            icon: Icon(
              hidePasswordAgain ? Icons.visibility_off : Icons.visibility,
              color: hidePasswordAgain ? grey : kPrimaryColor,
            ),
          ),
          //   labelText: 'Password',
          hintText: "Password Again",
          icon: Icon(Icons.lock),
          fillColor: Colors.transparent,
          filled: true,
          focusedBorder: UnderlineInputBorder(
            borderSide: flagPasswordAgain
                ? BorderSide(color: kPrimaryColor)
                : BorderSide(color: grey),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: flagPasswordAgain
                ? BorderSide(color: kPrimaryColor)
                : BorderSide(color: grey),
          ),
          border: InputBorder.none, // Çerçeve yok
        ),
        style: TextStyle(
          color: flagPasswordAgain
              ? kPrimaryColor
              : grey,
        ),
        maxLength: 20,
        onChanged: (value) {
          setState(() {
            if (value!.length < 7) {
              flagPasswordAgain = false;
            } else {
              flagPasswordAgain = true;
            }
          });
        },
        validator: (value) {
          if (value != controllerPassword.text) {
            return 'Passwords do not match.';
          }
          return null;
        },
        keyboardType: TextInputType.visiblePassword,
        obscureText: hidePasswordAgain,
      );
}
