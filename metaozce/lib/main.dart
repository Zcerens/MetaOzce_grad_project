import 'package:flutter/material.dart';

import 'package:metaozce/pages/SigninPage/signin_screen.dart';
import 'package:metaozce/const/constant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metaozce/pages/SignupPage/signup_screen.dart';
import 'package:metaozce/pages/WelcomePage/welcome_screen.dart';
import 'package:metaozce/pages/HomePage/components/home_view.dart';
import 'package:metaozce/pages/MyHotelsPage/components/my_hotels.dart';
import 'package:metaozce/widgets/navigationBar.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PersonelApp',
        theme: ThemeData(
              iconTheme: IconThemeData(
              color: iconColor, // Tüm ikonların rengini gri yap
            ),
            textTheme: GoogleFonts.jostTextTheme(//  textTheme: GoogleFonts.poppinsTextTheme(  //textTheme: GoogleFonts.jostTextTheme(
              Theme.of(context).textTheme,
              
            ),
            
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: Colors.white,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: const StadiumBorder(),
                maximumSize: const Size(double.infinity, 56),
                minimumSize: const Size(double.infinity, 56),
              ),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              hintStyle: TextStyle(color: Color.fromARGB(255, 168, 168, 168)),
              filled: true,
              fillColor: kPrimaryLightColor,
              iconColor: kPrimaryColor,
              prefixIconColor: kPrimaryColor,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide.none,
              ),
            )),
        home: NavigationBarMy
        ());
  }
}
