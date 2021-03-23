import 'package:flutter/material.dart';
import '../../config/style.dart';
import '../../config/string.dart';
import '../../config/color.dart';

class LogoText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return kTitleGradient.createShader(bounds);
      },
      child: RichText(text: TextSpan(text: appName, style: kTitleText)),
    );
  }
}
