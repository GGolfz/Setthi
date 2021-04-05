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
import 'package:setthi/widgets/layout/customDialog.dart';
import 'package:setthi/widgets/layout/errorDialog.dart';
import 'package:setthi/widgets/buttons/actionButton.dart';

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

  Widget _buildResetCompleteDialog(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Reset password successfully',
                    style: TextStyle(color: kGold500, fontSize: 16),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ActionButton(
                  text: "Ok",
                  color: kGold400,
                  onPressed: () {
                    Navigator.pop(context);
                    widget.changeModal(AuthType.signin);
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  bool validate() {
    return _password.text.isNotEmpty &&
        _confirmPassword.text.isNotEmpty &&
        _password.text == _confirmPassword.text;
  }

  void changePassword(BuildContext context) async {
    print(_password.text);
    print(_confirmPassword.text);
    if (validate()) {
      final auth = Provider.of<AuthenticateProvider>(context, listen: false);
      setState(() => _isLoading = true);
      try {
        await auth.changePassword(_password.text);
        setState(() => _isLoading = false);
        showCustomDialog(
            context: context, content: _buildResetCompleteDialog(context));
      } on HttpException catch (error) {
        showErrorDialog(context: context, text: error.message);
        setState(() => _isLoading = false);
      }
    } else {
      if (_password.text.isEmpty || _confirmPassword.text.isEmpty) {
        showErrorDialog(context: context, text: 'Password cannot be empty.');
      } else {
        showErrorDialog(context: context, text: 'Password does not match.');
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
