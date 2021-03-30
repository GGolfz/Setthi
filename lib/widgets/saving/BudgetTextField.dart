import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';

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
      
      controller: widget.textEditingController,
      keyboardType: widget.title == 'Title'? TextInputType.text : TextInputType.number,
      decoration: InputDecoration(
        filled: true,
        fillColor: kNeutralWhite,
        hintText: widget.title,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
