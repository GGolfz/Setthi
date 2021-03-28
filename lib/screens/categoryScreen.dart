import 'package:flutter/material.dart';
import 'package:setthi/widgets/layout/appBar.dart';

class CategoryScreen extends StatelessWidget {
  static const routeName = '/category';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SetthiAppBar(
        title: 'All Transactions',
        leading: BackButton(),
      ),
      body: Center(
        child: Text('Category'),
      ),
    );
  }
}
