import 'dart:io';

import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';

class ErrorDialog extends StatelessWidget {
  final String text;
  final bool isNetwork;
  ErrorDialog({this.text, this.isNetwork = false});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'An error occur',
        style: TextStyle(color: kRed400, fontSize: 30),
      ),
      content: Container(
          height: kSizeL,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: TextStyle(fontSize: 15),
                ),
                Icon(
                  Icons.close_outlined,
                  color: kRed400,
                )
              ])),
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
