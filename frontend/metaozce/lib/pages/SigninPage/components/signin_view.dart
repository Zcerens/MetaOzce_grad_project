import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metaozce/const/constant.dart';
import 'package:metaozce/pages/HomePage/home_screen.dart';
import 'package:metaozce/pages/SignupPage/signup_screen.dart';

class SigninView extends StatefulWidget {
  const SigninView({Key? key}) : super(key: key);

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
                                  left: 45, right: 45, bottom: 20,top:50),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: defaultPadding,
                                  ),
                                  Text(
                                    "HELLO SIGNIN",
                                    style: GoogleFonts.ubuntu(
                                        textStyle: TextStyle(color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 30)),
                                    textAlign: TextAlign.center, // Metni ortala
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
                                                      color: kPrimaryColor,
                                                      
                                                   
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
                                                    color: kPrimaryColor,
                                                    fontWeight: FontWeight.bold,
                                                    
                                                  ),
                                                  recognizer:
                                                      TapGestureRecognizer()
                                                        ..onTap = () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          SignupScreen()));
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
      builder: (context) => SizedBox(
        width: double.infinity, // Genişlik ayarı
        child: ElevatedButton(
          onPressed: () {
            final isValid = formKey.currentState!.validate();
            if (isValid) {
             Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor, // Buton rengi
            textStyle: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.045,
            ),
            elevation: 4, // Butonun yüksekliği
            shadowColor: Colors.grey, // Gölgelenme rengi
            padding: EdgeInsets.symmetric(vertical: 16), // Buton iç içe boşluk
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50), // Buton köşelerinin yuvarlanma derecesi
            ),
            minimumSize: Size(double.infinity, 50), // Butonun minimum boyutu
            tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Basılma boyutu
            animationDuration: Duration(milliseconds: 300), // Animasyon süresi
            // Butona basıldığında ara rengin belirlenmesi
      ),
          child: Text("SIGN IN",style: TextStyle(color: kPrimaryWhiteColor),),
        ),
      ),
    );

   bool flagUsername = false;
 Widget buildUsername() => TextFormField(
        decoration: InputDecoration(
          // labelText: 'Username',
          hintText: "Username",
          suffixIcon: flagUsername
              ? Icon(Icons.check, color: iconColor)
              : null,
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
          color: flagUsername ?kPrimaryColor : grey,
        ),
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

  bool flagPassword = false;Widget buildPassword() => TextFormField(
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
          color: flagPassword ? Color.fromARGB(255, 9, 129, 228) : Color.fromARGB(255, 168, 168, 168),
        ),
        maxLength: 20,
        onChanged: (value) {
          setState(() {
            if (value!.length < 7) {
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
