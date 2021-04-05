import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/config/style.dart';
import 'package:setthi/model/authType.dart';
import 'package:setthi/widgets/auth/authTextField.dart';
import 'package:setthi/widgets/buttons/primaryButton.dart';
import 'package:setthi/widgets/buttons/secondaryButton.dart';
import 'package:setthi/provider/authenicateProvider.dart';

class NewPasswordForm extends StatefulWidget {
  final Function changeModal;
  NewPasswordForm({this.changeModal});

  @override
  _NewPasswordFormState createState() => _NewPasswordFormState();
}

class _NewPasswordFormState extends State<NewPasswordForm> {
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticateProvider>(context);
    return Scaffold(
        backgroundColor: kNeutral450,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(children: [
          kSizedBoxVerticalS,
          Text(
            "Enter new password",
            style: kHeadline2White,
          ),
          kSizedBoxVerticalS,
          Form(
            key: _formKey,
            child: Column(
              children: [
                AuthTextField(
                    textController: _password,
                    placeholder: "6 digits recovery key",
                    type: AuthTextFieldType.password),
                AuthTextField(
                    textController: _confirmPassword,
                    placeholder: "6 digits recovery key",
                    type: AuthTextFieldType.confirmPassword),
                kSizedBoxVerticalS,
                PrimaryButton(
                    text: "SUBMIT",
                    onPressed: () async {
                      // widget.changeModal(AuthType.close);
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
