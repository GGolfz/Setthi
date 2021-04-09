import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../auth/authTextField.dart';
import '../buttons/primaryButton.dart';
import '../buttons/secondaryButton.dart';
import '../layout/customDialog.dart';
import '../layout/errorDialog.dart';
import '../buttons/actionButton.dart';
import '../../config/color.dart';
import '../../config/constants.dart';
import '../../config/style.dart';
import '../../model/authType.dart';
import '../../model/httpException.dart';
import '../../provider/authenicateProvider.dart';

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

  void dispose() {
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

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
    _formKey.currentState.save();
    return _formKey.currentState.validate();
  }

  void changePassword(BuildContext context) async {
    if (validate()) {
      final auth = Provider.of<AuthenticateProvider>(context, listen: false);
      try {
        setState(() => _isLoading = true);
        await auth.changePassword(_password.text);
        setState(() => _isLoading = false);
        showCustomDialog(
            context: context, content: _buildResetCompleteDialog(context));
      } on HttpException catch (error) {
        showErrorDialog(context: context, text: error.message);
        setState(() => _isLoading = false);
      }
    }
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
                      type: AuthTextFieldType.confirmPassword,
                      compareText: _password.text,
                    ),
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
