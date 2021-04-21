import 'package:flutter/material.dart';
import '../../config/style.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final String alertMessage;

  CustomTextField(
      {@required this.title,
      @required this.textEditingController,
      this.keyboardType = TextInputType.text,
      this.alertMessage});

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
        if (value.isEmpty)
          return 'Please enter ${alertMessage ?? title.toLowerCase()}';
        if (keyboardType == TextInputType.number) {
          if (double.tryParse(value) == null) {
            return 'Amount should be a number';
          }
          if (double.tryParse(value) <= 0) {
            return 'Amount should be positive';
          }
        }
        return null;
      },
    );
  }
}
