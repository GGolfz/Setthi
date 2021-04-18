import 'package:flutter/material.dart';
import '../../config/color.dart';
import '../../config/constants.dart';

class CustomDivider extends StatelessWidget {
  final Color color;
  final double height;
  CustomDivider({this.color = kNeutral200, this.height = kSizeXS});
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color,
      height: height,
    );
  }
}
