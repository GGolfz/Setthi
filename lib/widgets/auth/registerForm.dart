import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setthi/provider/authenicateProvider.dart';
import '../../config/color.dart';
import '../../config/constants.dart';
import '../../config/string.dart';
import '../../config/style.dart';
import '../../model/authType.dart';
import '../../widgets/auth/authTextField.dart';
import '../../widgets/buttons/primaryButton.dart';

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

  Future<void> register() async {
    var email = _email.text;
    var password = _password.text;
    setState(() {
      _isLoading = true;
    });
    if (validate()) {
      try {
        await Provider.of<AuthenticateProvider>(context, listen: false)
            .register(email, password);
        setState(() {
          _isLoading = false;
        });
        await widget.changeModal(AuthType.close);
      } catch (error) {}
    }
  }

  bool validate() {
    return _formKey.currentState.validate();
  }

  @override
  Widget build(BuildContext context) {
    _password.addListener(() {
      setState(() {});
    });
    return Scaffold(
      backgroundColor: kNeutral450,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              kSizedBoxVerticalS,
              Text(
                "Register",
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
                    AuthTextField(
                      textController: _confirmPassword,
                      placeholder: "Confirm Password",
                      type: AuthTextFieldType.confirmPassword,
                      compareText: _password.text,
                    ),
                    kSizedBoxVerticalS,
                    PrimaryButton(
                      text: "REGISTER",
                      onPressed: register,
                      isLoading: _isLoading,
                    ),
                    kSizedBoxVerticalS,
                    GestureDetector(
                      onTap: () {
                        widget.changeModal(AuthType.signin);
                      },
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: suggestSigninQuestion, style: kBody1White),
                          TextSpan(text: suggestSigninText, style: kBody1Gold)
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
