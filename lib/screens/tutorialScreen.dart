import 'package:flutter/material.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/widgets/layout/appBar.dart';

class TutorialScreen extends StatelessWidget {
  static const routeName = '/tutorial';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SetthiAppBar(
          title: 'Saving Goal Tutorial',
          leading: BackButton(),
        ),
        resizeToAvoidBottomInset: false,
        body: Center(
            child: Container(
          height: double.infinity,
          padding: EdgeInsets.symmetric(vertical: kSizeM),
          child: SingleChildScrollView(
            child: Image.asset(
              'assets/images/saving-tutorial-screen.png',
              fit: BoxFit.fitWidth,
            ),
          ),
        )));
  }
}
