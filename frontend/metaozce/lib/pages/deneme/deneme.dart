import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:metaozce/pages/deneme/BackendBloc.dart';


import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => BackendBloc(),
        child: MyWidget(),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final backendBloc = BlocProvider.of<BackendBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App with Python Backend'),
      ),
      body: Center(
        child: BlocBuilder<BackendBloc, String>(
          builder: (context, state) {
            return Text(backendBloc.fetchData().toString());
          },
        ),
    ));
  }
}