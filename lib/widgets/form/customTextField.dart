import 'package:flutter/material.dart';
import 'package:setthi/config/style.dart';

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
      style: kSubtitle2Black.copyWith(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        hintText: title,
        labelStyle: kSubtitle2Black.copyWith(fontWeight: FontWeight.w600),
      ),
      validator: (value) {
        if (value.isEmpty) return 'Please enter title';
        return null;
      },
    );
  }
}
