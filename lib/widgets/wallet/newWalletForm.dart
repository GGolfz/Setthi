import 'package:flutter/material.dart';
import './walletTextField.dart';
import '../../model/textFieldType.dart';
import '../buttons/primaryButton.dart';
import '../../config/style.dart';
import '../../config/color.dart';
import '../../config/constants.dart';

class NewWalletForm extends StatefulWidget {
  @override
  _NewWalletFormState createState() => _NewWalletFormState();
}

class _NewWalletFormState extends State<NewWalletForm> {
  final _title = TextEditingController();
  final _amount = TextEditingController();
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 200,
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Create new wallet',
                  style: TextStyle(color: kGold500, fontSize: 20),
                ),
              ],
            ),
            kSizedBoxVerticalXXS,
            WalletTextField(
              text: 'Title',
              type: TextFieldType.text,
              textEditingController: _title,
            ),
            kSizedBoxVerticalXXS,
            WalletTextField(
              text: 'Initial amount',
              type: TextFieldType.number,
              textEditingController: _amount,
            ),
            kSizedBoxVerticalS,
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: PrimaryButton(
                text: "Submit",
                onPressed: () {
                  print('Hello');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
