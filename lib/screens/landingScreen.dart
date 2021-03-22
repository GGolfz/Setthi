import 'package:flutter/material.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/widgets/landing/descriptionText.dart';
import 'package:setthi/widgets/logo/logoImage.dart';
import 'package:setthi/widgets/logo/logoText.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(vertical: kSizeS, horizontal: kSizeS * 1.5),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [LogoImage(), LogoText(), Descriptiontext()],
      ),
    ));
  }
}
