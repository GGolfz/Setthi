import 'package:flutter/material.dart';
import 'package:setthi/widgets/logoImage.dart';
import 'package:setthi/widgets/logoText.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [LogoImage(), LogoText()],
      ),
    ));
  }
}
