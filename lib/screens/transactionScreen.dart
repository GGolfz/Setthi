import 'package:flutter/material.dart';
import '../widgets/layout/appBar.dart';

class TransactionScreen extends StatelessWidget {
  static const routeName = '/transactions';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SetthiAppBar(
        title: 'All Transactions',
        leading: BackButton(),
      ),
      body: Center(
        child: Text('All Transactions'),
      ),
    );
  }
}
