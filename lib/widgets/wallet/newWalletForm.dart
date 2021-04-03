import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/walletProvider.dart';
import '../buttons/actionButton.dart';
import '../../config/color.dart';
import '../../config/constants.dart';

class NewWalletForm extends StatefulWidget {
  @override
  _NewWalletFormState createState() => _NewWalletFormState();
}

class _NewWalletFormState extends State<NewWalletForm> {
  String _title = "";
  double _amount = 0;
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
                TextFormField(
                  decoration: buildInputDecoration('Title'),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value.isEmpty) return 'Please enter title';
                    return null;
                  },
                  onSaved: (value) => _title = value,
                ),
                kSizedBoxVerticalXXS,
                TextFormField(
                  decoration: buildInputDecoration('Initial Amount'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) return 'Please enter initial amount';
                    return null;
                  },
                  onSaved: (value) => _amount = double.tryParse(value),
                ),
                kSizedBoxVerticalS,
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: ActionButton(
                    text: "Submit",
                    color: kGold300,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        Provider.of<WalletProvider>(context, listen: false)
                            .addWallet(_title, _amount);
                        Navigator.pop(context);
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
