import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _username = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  void dispose() {
    _username.dispose();
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
              kSizedBoxVerticalM,
              Text(
                "Register",
                style: TextStyle(color: kNeutralWhite, fontSize: kSizeS * 1.5),
              ),
              kSizedBoxVerticalM,
              Form(
                key: _formKey,
                child: Column(
                  children: [],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
