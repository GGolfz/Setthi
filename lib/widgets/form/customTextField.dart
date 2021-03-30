import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;

  CustomTextField(
      {@required this.title,
      @required this.textEditingController,
      this.keyboardType = TextInputType.text});

  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: kNeutralWhite,
        hintText: title,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
