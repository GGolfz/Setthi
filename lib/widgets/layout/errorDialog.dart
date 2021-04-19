import 'dart:io';
import 'package:flutter/material.dart';
import '../../config/color.dart';
import '../../config/constants.dart';

class ErrorDialog extends StatelessWidget {
  final String text;
  final bool isNetwork;
  ErrorDialog({this.text, this.isNetwork = false});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: RichText(
        text: TextSpan(
            text: 'An error occur',
            style: TextStyle(color: kRed400, fontSize: 30)),
      ),
      content: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Text(
            text,
            style: TextStyle(fontSize: 15),
          )),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            isNetwork ? exit(0) : Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],
      elevation: kSizeXXS,
      shape: RoundedRectangleBorder(borderRadius: kBorderRadiusS),
    );
  }
}

void showErrorDialog(
    {BuildContext context, String text, bool isNetwork = false}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "",
    barrierColor: kNeutralWhiteFade,
    pageBuilder: (ctx, animation1, animation2) => ErrorDialog(
      text: text,
      isNetwork: isNetwork,
    ),
  );
}
