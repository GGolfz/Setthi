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

class TokenForm extends StatefulWidget {
  final Function changeModal;
  TokenForm({this.changeModal});

  @override
  _TokenFormState createState() => _TokenFormState();
}

class _TokenFormState extends State<TokenForm> {
  final _recoveryToken = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  void checkResetPassword(BuildContext context) async {
    if (validate()) {
      final auth = Provider.of<AuthenticateProvider>(context, listen: false);
      setState(() => _isLoading = true);
      try {
        await auth.checkResetPassword(_recoveryToken.text);
        setState(() => _isLoading = false);
        widget.changeModal(AuthType.newPassword);
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
      backgroundColor: kNeutral450,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              kSizedBoxVerticalS,
              Text(
                "Enter the recovery key",
                style: kHeadline2White,
              ),
              kSizedBoxVerticalS,
              Text(
                "We already sent you 6 digits recovery key in your email, please enter the recovery key below.",
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
                        textController: _recoveryToken,
                        placeholder: "6 digits recovery key",
                        type: AuthTextFieldType.number),
                    kSizedBoxVerticalS,
                    PrimaryButton(
                      text: "SUBMIT",
                      onPressed: () => checkResetPassword(context),
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
