import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/config/style.dart';

class ActionButton extends StatelessWidget {
  final Color color;
  final String text;
  final Function onPressed;
  final bool isOutlined;
  final bool isFullWidth;
  ActionButton(
      {this.text,
      this.onPressed,
      this.color = kNeutral450,
      this.isOutlined = false,
      this.isFullWidth = false});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: kSizeM * 1.5,
        width: isFullWidth ? double.infinity : null,
        decoration: BoxDecoration(
            borderRadius: isFullWidth ? kBorderRadiusS : kBorderRadiusXS,
            border: isOutlined ? Border.all(color: color, width: 2) : null,
            color: isOutlined ? kTransparent : color),
        child: Center(
            child: Text(
          text,
          textAlign: TextAlign.center,
          style: kSubtitle1Black.copyWith(
              color: isOutlined ? color : kNeutralWhite,
              fontWeight: FontWeight.w600),
        )),
      ),
    );
  }
}
