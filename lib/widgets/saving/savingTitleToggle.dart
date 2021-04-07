import 'package:flutter/material.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/config/style.dart';

class SavingTitleToggle extends StatelessWidget {
  final String text;
  final bool isOpen;
  final Function toggle;
  SavingTitleToggle({this.text, this.isOpen, this.toggle});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(kSizeXS),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(text, style: kHeadline3Black),
          IconButton(
            icon: Icon(isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down),
            onPressed: toggle,
          )
        ]));
  }
}
