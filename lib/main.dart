import 'package:flutter/material.dart';
import 'package:setthi/config/string.dart';
import 'package:setthi/screens/LandingScreen.dart';
import 'package:setthi/screens/mainScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final auth = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      home: auth ? LandingScreen() : MainScreen(),
    );
  }
}
