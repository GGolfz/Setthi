import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/config/style.dart';
import 'package:setthi/model/authType.dart';
import 'package:setthi/widgets/auth/authTextField.dart';
import 'package:setthi/widgets/buttons/primaryButton.dart';
import 'package:setthi/widgets/buttons/secondaryButton.dart';

class TokenForm extends StatefulWidget {
  final Function changeModal;
  TokenForm({this.changeModal});

  @override
  _TokenFormState createState() => _TokenFormState();
}

class _TokenFormState extends State<TokenForm> {
  final _email = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kNeutral450,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
          kSizedBoxVerticalS,
          Text(
            "Enter the recovery key",
            style: kHeadline2White,
          ),
          kSizedBoxVerticalS,
          Text(
            "We already sent you 6 digits recovery key in your email, please enter the recovery key below.",
            textAlign: TextAlign.center,
            softWrap: true,
            style: kBody1White,
          ),
          kSizedBoxVerticalS,
          Form(
            key: _formKey,
            child: Column(
              children: [
                AuthTextField(
                    textController: _email,
                    placeholder: "6 digits recovery key",
                    type: AuthTextFieldType.email),
                kSizedBoxVerticalS,
                PrimaryButton(
                    text: "SUBMIT",
                    onPressed: () {
                      widget.changeModal(AuthType.close);
                    }),
                kSizedBoxVerticalS,
                SecondaryButton(
                    text: "CANCEL",
                    onPressed: () {
                      widget.changeModal(AuthType.signin);
                    }),
              ],
            ),
          )
        ]))));
  }
}
