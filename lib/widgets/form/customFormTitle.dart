import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';

class CustomFormTitle extends StatelessWidget {
  final String title;
  CustomFormTitle({@required this.title});
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(color: kGold500, fontSize: 20),
      textAlign: TextAlign.center,
    );
  }
}
