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

class ForgetForm extends StatefulWidget {
  final Function changeModal;
  ForgetForm({this.changeModal});

  @override
  _ForgetFormState createState() => _ForgetFormState();
}

class _ForgetFormState extends State<ForgetForm> {
  final _email = TextEditingController();
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
            "Forget Password",
            style: kHeadline2White,
          ),
          kSizedBoxVerticalS,
          Text(
            "Enter your email address below, we will send you insructions how to change password.",
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
                    placeholder: "Email",
                    type: AuthTextFieldType.email),
                kSizedBoxVerticalS,
                PrimaryButton(
                    text: "SEND",
                    onPressed: () async {
                      print('submit');
                      print(_email.text);
                      await authProvider.forgetPassword(_email.text);
                      widget.changeModal(AuthType.token);
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
