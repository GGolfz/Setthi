import 'package:flutter/material.dart';
import 'package:setthi/widgets/layout/appBar.dart';

class LabelScreen extends StatelessWidget {
  static const routeName = '/label';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SetthiAppBar(
        title: 'Label',
        leading: BackButton(),
      ),
      body: Center(
        child: Text('Label'),
      ),
    );
  }
}
