import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../buttons/actionButton.dart';
import '../form/customTextField.dart';
import '../layout/errorDialog.dart';
import '../../model/httpException.dart';
import '../../provider/walletProvider.dart';
import '../../config/color.dart';
import '../../config/constants.dart';

class NewWalletForm extends StatefulWidget {
  @override
  _NewWalletFormState createState() => _NewWalletFormState();
}

class _NewWalletFormState extends State<NewWalletForm> {
  TextEditingController _title = TextEditingController();
  TextEditingController _amount = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  InputDecoration buildInputDecoration(String hintText) {
    return InputDecoration(
      filled: true,
      fillColor: kNeutralWhite,
      hintText: hintText,
      contentPadding: EdgeInsets.zero,
    );
  }

  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
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
                CustomTextField(title: 'Title', textEditingController: _title),
                kSizedBoxVerticalXXS,
                CustomTextField(
                  title: 'Initial Amount',
                  textEditingController: _amount,
                  keyboardType: TextInputType.number,
                ),
                kSizedBoxVerticalS,
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ActionButton(
                    text: "Submit",
                    color: kGold300,
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        try {
                          _formKey.currentState.save();
                          await Provider.of<WalletProvider>(context,
                                  listen: false)
                              .addWallet(
                                  _title.text, double.tryParse(_amount.text));
                          Navigator.pop(context);
                        } on HttpException catch (error) {
                          showErrorDialog(
                              context: context,
                              text: error.message,
                              isNetwork: error.isInternetProblem);
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
