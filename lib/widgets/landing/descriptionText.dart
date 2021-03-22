import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/string.dart';
import '../../config/constants.dart';

class Descriptiontext extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Text(descriptionText,
          textAlign: TextAlign.center,
          style: GoogleFonts.quicksand(
              fontSize: kSizeXS * 1.6, color: kNeutral800)),
    );
  }
}
