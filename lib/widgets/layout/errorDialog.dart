import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';

class ErrorDialog extends StatelessWidget {
  final String text;
  ErrorDialog({this.text});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('An error occur'),
      content: Text(text),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],
      elevation: kSizeXXS,
      shape: RoundedRectangleBorder(borderRadius: kBorderRadiusS),
    );
  }
}

void showCustomDialog({BuildContext context, String text}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "",
    barrierColor: kNeutralWhiteFade,
    pageBuilder: (ctx, animation1, animation2) => ErrorDialog(text: text),
  );
}
