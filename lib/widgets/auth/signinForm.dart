import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/modal/authType.dart';
import 'package:setthi/widgets/auth/authTextField.dart';
import 'package:setthi/widgets/buttons/primaryButton.dart';

class SigninForm extends StatefulWidget {
  final Function changeModal;
  const SigninForm({this.changeModal});
  @override
  _SigninFormState createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kNeutral450,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              kSizedBoxVerticalS,
              Text(
                "Sign In",
                style: TextStyle(color: kNeutralWhite, fontSize: kSizeS * 1.5),
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
                    AuthTextField(
                        textController: _password,
                        placeholder: "Password",
                        type: AuthTextFieldType.password),
                    kSizedBoxVerticalS,
                    PrimaryButton(
                        text: "SIGN IN",
                        onPressed: () {
                          _formKey.currentState.validate();
                        }),
                    kSizedBoxVerticalS,
                    GestureDetector(
                      onTap: () {
                        widget.changeModal(AuthType.register);
                      },
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "New here ? ",
                              style: TextStyle(
                                  color: kNeutralWhite,
                                  fontSize: kSizeXS * 1.8)),
                          TextSpan(
                              text: "Create Account",
                              style: TextStyle(
                                  color: kGold500, fontSize: kSizeXS * 1.8))
                        ]),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
