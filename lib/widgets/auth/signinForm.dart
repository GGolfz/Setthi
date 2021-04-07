import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setthi/provider/authenicateProvider.dart';
import 'package:setthi/model/httpException.dart';
import '../../widgets/layout/errorDialog.dart';
import '../../config/color.dart';
import '../../config/constants.dart';
import '../../config/string.dart';
import '../../config/style.dart';
import '../../model/authType.dart';
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

  Future<void> login(BuildContext context) async {
    var email = _email.text;
    var password = _password.text;
    if (validate()) {
      setState(() => _isLoading = true);
      try {
        await Provider.of<AuthenticateProvider>(context, listen: false)
            .login(email, password);
        setState(() {
          _isLoading = false;
        });
        await widget.changeModal(AuthType.close);
        setState(() => _isLoading = false);
      } on HttpException catch (error) {
        setState(() => _isLoading = false);
        showErrorDialog(context: context, text: error.message);
      }
    }
  }

  bool validate() {
    return _formKey.currentState.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                        GestureDetector(
                          child: Text(
                            forgetText,
                            style: kBody1White,
                          ),
                          onTap: () {
                            widget.changeModal(AuthType.forget);
                          },
                        )
                      ],
                    ),
                    kSizedBoxVerticalS,
                    PrimaryButton(
                      text: "SIGN IN",
                      onPressed: () => login(context),
                      isLoading: _isLoading,
                    ),
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
