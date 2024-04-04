import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metaozce/const/constant.dart';
import 'package:metaozce/pages/SigninPage/signin_screen.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {

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

  @override
  Widget build(BuildContext context) {
    return  ListView(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  
                                ),
                              ),
                            ),
                          /*  Image.asset(
                              "assets/logo/logodhp2.PNG",
                              width: 200,
                            ),*/
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 45, right: 45, bottom: 20),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: defaultPadding,
                                  ),
                                  Text(
                                    "METAOZCE",
                                    style: GoogleFonts.michroma(
                                        textStyle: TextStyle(color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 19)),
                                    textAlign: TextAlign.center, // Metni ortala
                                  ),
                                  Divider(
                                    height: MediaQuery.of(context).size.height *
                                        0.01,
                                    color: Colors.grey[400],
                                    thickness: 1,
                                  ),
                                  SizedBox(
                                    height: defaultPadding * 10,
                                  ),
                                  buildUsername(),
                                  const SizedBox(height: defaultPadding),
                                  buildPassword(),
                                  const SizedBox(height: defaultPadding),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 25),
                                      child: RichText(
                                        text: TextSpan(
                                            style: TextStyle(
                                                color: textColorMid,
                                                fontSize: 15),
                                            children: [
                                              TextSpan(
                                                  text:
                                                      "Forgot password?",
                                                  style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                      color: textColorMid,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                  ),
                                                  )
                                            ]),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: defaultPadding * 2),
                                  buildLogin(),
                                  const SizedBox(height: defaultPadding),
                                  Center(//todo logolar buraya da gelebilir
                                  ),
                                  const SizedBox(height: defaultPadding),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 0),
                                      child: RichText(
                                        text: TextSpan(
                                            style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  color: textColorMid,
                                                  fontSize: 14),
                                            ),
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
                                            style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  color: textColorMid,
                                                  fontSize: 14),
                                            ),
                                            children: [
                                              TextSpan(
                                                  text: "Don't have account?" ),
                                              TextSpan(
                                                  text: " " +
                                                      "Signup",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: textInfoColor,
                                                    fontWeight: FontWeight.bold,
                                                    decoration: TextDecoration
                                                        .underline,
                                                  ),
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          SigninScreen()));//todo
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
                      )
                   
          ),
        ],
      
    );
  }

  Widget buildLogin() => Builder(
        builder: (context) => Container(
          width: MediaQuery.of(context).size.width*0.4,
          child: ElevatedButton(
            onPressed: () {
              final isValid = formKey.currentState!.validate();
              isValid
                  ? {
                      print("giriş başarılı")
                    }
                  : null; 
            },
            child: Text("Login",
            style: TextStyle(fontSize:MediaQuery.of(context).size.width*0.045 ),),
          ),
        ),
      );

  Widget buildEmail() => TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "email boş olamaz 281";
        } else {
          return null;
        }
      },
      controller: controllerUsername,
      decoration:
          InputDecoration(hintText: "288"));

   bool flagUsername = false;
  Widget buildUsername() => TextFormField(
        decoration: InputDecoration(
          // labelText: 'Username',
          hintText: "Username",
          suffixIcon: flagUsername
              ? Icon(Icons.check, color: Colors.blue)
              : null,
          icon: Icon(Icons.person),
          fillColor: Colors.white,
          focusedBorder: UnderlineInputBorder(
            borderSide: flagUsername
                ? BorderSide(color: Colors.blue)
                : BorderSide(color: Colors.grey),
          ),
          border: OutlineInputBorder(),
        ),
        style: TextStyle(
          color: flagUsername ? Colors.blue : Colors.grey,
        ),
        validator: (value) {
          if (value!.length < 5) {
            return "Şifre 5ten kısa olamaz.";
          } else {
            return null;
          }
        },
        maxLength: 30,
        onChanged: (value) {
          setState(() {
            if (value!.length < 5) {
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
              icon:
                  Icon(hidePassword ? Icons.visibility_off : Icons.visibility)),
          //   labelText: 'Password',
          hintText: "255",
          icon: Icon(Icons.lock),
          fillColor: Colors.white,
          focusedBorder: UnderlineInputBorder(
            borderSide: flagPassword == true
                ? BorderSide(color: Colors.green)
                : BorderSide(color: Colors.red),
          ),
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.length < 2) {
            return "2den az olamaz";
          } else {
            return null;
          }
        },
        maxLength: 20,
        onChanged: (value) {
          setState(() {
            if (value!.length < 2) {
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
