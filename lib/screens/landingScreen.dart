import 'package:flutter/material.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/widgets/buttons/primaryButton.dart';
import 'package:setthi/widgets/buttons/secondaryButton.dart';
import 'package:setthi/widgets/landing/descriptionText.dart';
import 'package:setthi/widgets/layout/customDivider.dart';
import 'package:setthi/widgets/logo/logoImage.dart';
import 'package:setthi/widgets/logo/logoText.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(vertical: kSizeS, horizontal: kSizeM),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LogoImage(),
          LogoText(),
          kSizedBoxVerticalXXS,
          Descriptiontext(),
          kSizedBoxVerticalL,
          PrimaryButton(text: "SIGN IN", onPressed: () {}),
          CustomDivider(),
          SecondaryButton(text: "REGISTER", onPressed: () {}),
        ],
      ),
    ));
  }
}
