import 'package:flutter/material.dart';
import 'package:image_labeler/pages/extraDetail.dart';
import 'package:image_labeler/pages/mainDetail.dart';
import 'package:image_labeler/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => Home(),
        '/mainDetail': (context) => const MainDetail(),
        '/extraDetail': (context) => const ExtraDetail(),
      },
    );
  }
}
