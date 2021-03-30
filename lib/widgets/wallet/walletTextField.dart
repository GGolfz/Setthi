import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';
import '../../model/textFieldType.dart';

class WalletTextField extends StatefulWidget {
  final String text;
  final TextFieldType type;
  final TextEditingController textEditingController;

  WalletTextField({
    @required this.text,
    @required this.type,
    @required this.textEditingController,
  });
  @override
  _WalletTextFieldState createState() => _WalletTextFieldState();
}

class _WalletTextFieldState extends State<WalletTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      keyboardType: widget.type == TextFieldType.text
          ? TextInputType.text
          : TextInputType.number,
      decoration: InputDecoration(
        filled: true,
        fillColor: kNeutralWhite,
        hintText: widget.text,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
