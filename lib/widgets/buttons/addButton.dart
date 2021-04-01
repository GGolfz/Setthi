import 'package:flutter/material.dart';
import 'package:setthi/widgets/layout/customDialog.dart';
import 'package:setthi/widgets/transaction/addTransactionForm.dart';
import '../../config/color.dart';

class AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(
        Icons.add,
        color: kGold200,
      ),
      backgroundColor: kNeutral450,
      onPressed: () {
        showCustomDialog(context: context, content: AddTransactionForm());
      },
    );
  }
}
