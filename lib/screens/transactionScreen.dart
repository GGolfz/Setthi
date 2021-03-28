import 'package:flutter/material.dart';

class TransactionScreen extends StatelessWidget {
  static const routeName = '/transactions';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("All Transactions"),
      ),
    );
  }
}
