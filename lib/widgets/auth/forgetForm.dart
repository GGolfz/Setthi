import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth/authTextField.dart';
import '../buttons/primaryButton.dart';
import '../buttons/secondaryButton.dart';
import '../layout/errorDialog.dart';
import '../../config/color.dart';
import '../../config/constants.dart';
import '../../config/style.dart';
import '../../model/authType.dart';
import '../../model/httpException.dart';
import '../../provider/authenicateProvider.dart';

class ForgetForm extends StatefulWidget {
  final Function changeModal;
  ForgetForm({this.changeModal});

  @override
  _ForgetFormState createState() => _ForgetFormState();
}

class _ForgetFormState extends State<ForgetForm> {
  final _email = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  bool validate() {
    return _formKey.currentState.validate();
  }

  void confirmForget(BuildContext context) async {
    if (validate()) {
      final auth = Provider.of<AuthenticateProvider>(context, listen: false);
      try {
        setState(() => _isLoading = true);
        await auth.forgetPassword(_email.text);
        await widget.changeModal(AuthType.token);
        setState(() => _isLoading = false);
      } on HttpException catch (error) {
        setState(() => _isLoading = false);
        showErrorDialog(context: context, text: error.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kNeutral450,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                      onPressed: () => confirmForget(context),
                      isLoading: _isLoading,
                    ),
                    kSizedBoxVerticalS,
                    SecondaryButton(
                      text: "CANCEL",
                      onPressed: () {
                        widget.changeModal(AuthType.signin);
                      },
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
