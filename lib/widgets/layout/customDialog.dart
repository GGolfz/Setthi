import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';

class CustomDialog extends StatelessWidget {
  final Widget content;
  CustomDialog({this.content});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: content,
      elevation: kSizeXXS,
      shape: RoundedRectangleBorder(borderRadius: kBorderRadiusS),
    );
  }
}

void showCustomDialog({BuildContext context, Widget content}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "",
    barrierColor: kNeutralWhiteFade,
    pageBuilder: (ctx, animation1, animation2) =>
        CustomDialog(content: content == null ? Container() : content),
  );
}
