import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/modal/authType.dart';
import 'package:setthi/widgets/auth/authTextField.dart';
import 'package:setthi/widgets/buttons/primaryButton.dart';

class RegisterForm extends StatefulWidget {
  final Function changeModal;
  const RegisterForm({this.changeModal});
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();

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
                "Register",
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
                    AuthTextField(
                        textController: _confirmPassword,
                        placeholder: "Confirm Password",
                        type: AuthTextFieldType.confirmPassword),
                    kSizedBoxVerticalS,
                    PrimaryButton(
                        text: "REGISTER",
                        onPressed: () {
                          _formKey.currentState.validate();
                        }),
                    kSizedBoxVerticalS,
                    GestureDetector(
                      onTap: () {
                        widget.changeModal(AuthType.login);
                      },
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: "Already have an account ? ",
                              style: TextStyle(
                                  color: kNeutralWhite,
                                  fontSize: kSizeXS * 1.8)),
                          TextSpan(
                              text: "Sign In",
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
