import 'package:flutter/material.dart';
import 'package:setthi/model/transactionType.dart';
import 'package:setthi/widgets/transaction/selectTypeBar.dart';

class AddTransactionForm extends StatefulWidget {
  @override
  _AddTransactionFormState createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends State<AddTransactionForm> {
  TransactionType _current = TransactionType.Income;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: 400,
      child: Column(
        children: [
          SelectTypeBar(
              current: _current,
              onChange: (value) {
                setState(() {
                  _current = value;
                });
              })
        ],
      ),
    );
  }
}
