import 'package:flutter/material.dart';
import '../../config/constants.dart';

class LogoImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: kSizeXXL,
      height: kSizeXXL,
      child: Image.asset('assets/images/app-logo.png', fit: BoxFit.contain),
    );
  }
}
