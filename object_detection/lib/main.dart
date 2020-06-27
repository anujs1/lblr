import 'package:flutter/material.dart';
import 'package:objectdetection/pages/extraDetail.dart';
import 'package:objectdetection/pages/mainDetail.dart';
import 'package:objectdetection/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => Home(),
        '/mainDetail': (context) => MainDetail(),
        '/extraDetail': (context) => ExtraDetail(),
      },
    );
  }
}
