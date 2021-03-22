import 'package:flutter/material.dart';
import 'package:setthi/config/string.dart';
import 'package:setthi/screens/LandingScreen.dart';
import 'package:setthi/screens/mainScreen.dart';

void main() {
  runApp(SetthiApp());
}

class SetthiApp extends StatefulWidget {
  @override
  _SetthiAppState createState() => _SetthiAppState();
}

class _SetthiAppState extends State<SetthiApp> {
  var auth = false;
  void login() {
    setState(() {
      auth = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      home: auth ? MainScreen() : LandingScreen(login),
    );
  }
}
