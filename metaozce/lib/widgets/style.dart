import 'package:flutter/material.dart';

class AppLargeText extends StatelessWidget {
  double size;
  final String text;
  final Color color;

  AppLargeText({this.size = 24, required this.text, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class AppColorText extends StatelessWidget {
  double size;
  final String text;
  final Color color;

  AppColorText({this.size = 30, required this.text, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.blue[700],
        fontSize: size,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class AppText extends StatelessWidget {
  double size;
  final String text;
  final Color color;

  AppText({this.size = 15, required this.text, this.color = Colors.black45});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
