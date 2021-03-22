import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/string.dart';
import '../../config/color.dart';
import '../../config/constants.dart';

class LogoText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final titleStyle = GoogleFonts.cinzel()
        .copyWith(fontSize: kSizeL, fontWeight: FontWeight.bold);
    return ShaderMask(
      shaderCallback: (bounds) {
        return kTitleGradient.createShader(bounds);
      },
      child: RichText(text: TextSpan(text: appName, style: titleStyle)),
    );
  }
}
