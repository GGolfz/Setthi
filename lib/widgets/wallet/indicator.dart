import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/config/style.dart';

class Indicator extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final MainAxisAlignment alignment;
  Indicator(
      {this.text,
      this.color,
      this.textColor = kNeutral700,
      this.alignment = MainAxisAlignment.start});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: Row(mainAxisAlignment: alignment, children: [
        Container(
          width: 20,
          height: 20,
          decoration:
              BoxDecoration(color: color, borderRadius: kBorderRadiusXS),
        ),
        kSizedBoxHorizontalXS,
        Text(
          text,
          style: kBody1Black.copyWith(color: textColor),
        )
      ]),
    );
  }
}
