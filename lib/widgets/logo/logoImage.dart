import 'package:flutter/material.dart';
import '../../config/constants.dart';

class LogoImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: kSizeXL * 1.5,
      height: kSizeXL * 1.5,
      child: Image.asset(
        'assets/images/app-logo.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
