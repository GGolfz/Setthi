import 'package:flutter/material.dart';
import 'package:setthi/config/string.dart';
import 'package:setthi/screens/LandingScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      home: LandingScreen(),
    );
  }
}
