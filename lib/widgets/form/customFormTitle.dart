import 'package:flutter/material.dart';
import 'package:setthi/config/style.dart';

class CustomFormTitle extends StatelessWidget {
  final String title;
  CustomFormTitle({@required this.title});
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: kHeadline4Gold.copyWith(fontWeight: FontWeight.w600),
      textAlign: TextAlign.center,
    );
  }
}
