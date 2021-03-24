import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/config/style.dart';

class BudgetTextField extends StatefulWidget {
  final String title;
  final TextEditingController textEditingController;

  BudgetTextField({
    @required this.title,
    @required this.textEditingController,
  });
  @override
  _BudgetTextFieldState createState() => _BudgetTextFieldState();
}

class _BudgetTextFieldState extends State<BudgetTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: kBody1Gold,
      keyboardType: widget.title == 'Title'? TextInputType.text : TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: kBorderRadiusXS * 1.5, borderSide: BorderSide.none),
        filled: true,
        fillColor: kNeutralWhite,
        hintText: widget.title,
        hintStyle: kBody1Gold,
        contentPadding: EdgeInsets.symmetric(
          horizontal: kSizeS * 1.25,
        ),
      ),
    );
  }
}
