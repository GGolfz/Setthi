import 'dart:ui';
import 'package:flutter/material.dart';
import '../../config/color.dart';
import '../../config/constants.dart';
import '../../config/style.dart';

class ActionButton extends StatelessWidget {
  final Color color;
  final String text;
  final Function onPressed;
  final bool isOutlined;
  final bool isFullWidth;
  final bool isLoading;
  ActionButton(
      {this.text,
      this.onPressed,
      this.color = kNeutral450,
      this.isOutlined = false,
      this.isFullWidth = false,
      this.isLoading = false});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? () {} : onPressed,
      child: Container(
        height: kSizeM * 1.5,
        width: isFullWidth ? double.infinity : null,
        decoration: BoxDecoration(
            borderRadius: isFullWidth ? kBorderRadiusS : kBorderRadiusXS,
            border: isOutlined ? Border.all(color: color, width: 1) : null,
            color: isOutlined ? kTransparent : color),
        child: Center(
            child: isLoading
                ? CircularProgressIndicator()
                : Text(
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
