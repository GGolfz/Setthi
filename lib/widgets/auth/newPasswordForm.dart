import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/config/style.dart';
import 'package:setthi/model/authType.dart';
import 'package:setthi/model/http_exception.dart';
import 'package:setthi/widgets/auth/authTextField.dart';
import 'package:setthi/widgets/buttons/primaryButton.dart';
import 'package:setthi/widgets/buttons/secondaryButton.dart';
import 'package:setthi/provider/authenicateProvider.dart';
import 'package:setthi/widgets/layout/errorDialog.dart';

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
  bool _isLoading = false;

  void changePassword(BuildContext context) async {
    final authProvider =
        Provider.of<AuthenticateProvider>(context, listen: false);
    try {
      setState(() => _isLoading = true);
      await authProvider.changePassword(_password.text);
      setState(() => _isLoading = false);
      widget.changeModal(AuthType.signin);
    } on HttpException catch (error) {
      showErrorDialog(context: context, text: error.message);
      setState(() => _isLoading = false);
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
                        placeholder: "new password",
                        type: AuthTextFieldType.password),
                    kSizedBoxVerticalS,
                    AuthTextField(
                        textController: _confirmPassword,
                        placeholder: "confirm new password",
                        type: AuthTextFieldType.confirmPassword),
                    kSizedBoxVerticalS,
                    PrimaryButton(
                      text: "SUBMIT",
                      isLoading: _isLoading,
                      onPressed: () => changePassword(context),
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
