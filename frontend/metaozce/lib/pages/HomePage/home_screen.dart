import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Boş Sayfa'),
      ),
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          color: Colors.pink,
        ),
      ),
    );
  }
}
