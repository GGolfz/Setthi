import 'package:flutter/material.dart';
import 'package:setthi/config/style.dart';
import '../../config/color.dart';
import '../../config/constants.dart';

class CongratsDialog extends StatelessWidget {
  final String savingName;
  CongratsDialog({this.savingName});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: RichText(
        text: TextSpan(
            text: 'Congratulations !',
            style: TextStyle(color: kNeutral700, fontSize: 30)),
      ),
      content: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Text(
            'Your saving goal\n($savingName)\nis finished.',
            style: kBody1Black.copyWith(fontSize: 18),
            textAlign: TextAlign.center,
          )),
      actions: <Widget>[
        TextButton(
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

void showCongratsDialog({BuildContext context, String savingName}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "",
    barrierColor: kNeutralWhiteFade,
    pageBuilder: (ctx, animation1, animation2) => CongratsDialog(
      savingName: savingName,
    ),
  );
}
