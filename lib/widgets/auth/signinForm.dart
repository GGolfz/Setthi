import 'package:flutter/material.dart';
import '../../config/color.dart';
import '../../config/constants.dart';
import '../../config/string.dart';
import '../../config/style.dart';
import '../../modal/authType.dart';
import '../../widgets/auth/authTextField.dart';
import '../../widgets/buttons/primaryButton.dart';

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
                style: kHeadline2White,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          forgetText,
                          style: kBody1White,
                        )
                      ],
                    ),
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
                              text: suggestRegisterQuestion,
                              style: kBody1White),
                          TextSpan(text: suggestRegisterText, style: kBody1Gold)
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
