import 'package:flutter/material.dart';
import 'package:setthi/widgets/auth/forgetForm.dart';
import 'package:setthi/widgets/auth/newPasswordForm.dart';
import 'package:setthi/widgets/auth/tokenForm.dart';
import '../config/color.dart';
import '../config/constants.dart';
import '../model/authType.dart';
import '../widgets/auth/registerForm.dart';
import '../widgets/auth/signinForm.dart';
import '../widgets/buttons/primaryButton.dart';
import '../widgets/buttons/secondaryButton.dart';
import '../widgets/landing/descriptionText.dart';
import '../widgets/layout/divider.dart';
import '../widgets/logo/logoImage.dart';
import '../widgets/logo/logoText.dart';

class LandingScreen extends StatelessWidget {
  void _showBottomModal(context, Widget widget, type) {
    showModalBottomSheet(
        context: context,
        barrierColor: kTransparent,
        isScrollControlled: true,
        backgroundColor: kTransparent,
        builder: (ctx) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: _buildBottomModalContainer(widget, type),
          );
        });
  }

  Widget _buildBottomModalContainer(Widget widget, type) {
    return Container(
      height: type == AuthType.register ? 400 : 380,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: kSizeS * 1.5, vertical: kSizeS),
      decoration: BoxDecoration(
          color: kNeutral450,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(kSizeM),
              topRight: Radius.circular(kSizeM))),
      child: widget,
    );
  }

  @override
  Widget build(BuildContext context) {
    void _changeModal(type) {
      switch (type) {
        case AuthType.signin:
          Navigator.of(context).pop();
          _showBottomModal(
              context, SigninForm(changeModal: _changeModal), AuthType.signin);
          break;
        case AuthType.register:
          Navigator.of(context).pop();
          _showBottomModal(context, RegisterForm(changeModal: _changeModal),
              AuthType.register);
          break;
        case AuthType.forget:
          Navigator.of(context).pop();
          _showBottomModal(
              context, ForgetForm(changeModal: _changeModal), AuthType.forget);
          break;
        case AuthType.token:
          Navigator.of(context).pop();
          _showBottomModal(
              context, TokenForm(changeModal: _changeModal), AuthType.token);
          break;
        case AuthType.newPassword:
          Navigator.of(context).pop();
          _showBottomModal(context, NewPasswordForm(changeModal: _changeModal),
              AuthType.newPassword);
          break;
        default:
          Navigator.of(context).pop();
      }
    }

    return Scaffold(
        backgroundColor: kGold100,
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.symmetric(vertical: kSizeS, horizontal: kSizeM),
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
              child: Column(
            children: [
              kSizedBoxVerticalL,
              LogoImage(),
              LogoText(),
              kSizedBoxVerticalXXS,
              Descriptiontext(),
              kSizedBoxVerticalL,
              PrimaryButton(
                  text: "SIGN IN",
                  onPressed: () {
                    _showBottomModal(context,
                        SigninForm(changeModal: _changeModal), AuthType.signin);
                  }),
              CustomDivider(color: kNeutral300, height: kSizeM),
              SecondaryButton(
                text: "REGISTER",
                onPressed: () {
                  _showBottomModal(
                      context,
                      RegisterForm(changeModal: _changeModal),
                      AuthType.register);
                },
                isDark: false,
              ),
            ],
          )),
        ));
  }
}
