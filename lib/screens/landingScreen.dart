import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/modal/authType.dart';
import 'package:setthi/widgets/auth/registerForm.dart';
import 'package:setthi/widgets/auth/signinForm.dart';
import 'package:setthi/widgets/buttons/primaryButton.dart';
import 'package:setthi/widgets/buttons/secondaryButton.dart';
import 'package:setthi/widgets/landing/descriptionText.dart';
import 'package:setthi/widgets/layout/customDivider.dart';
import 'package:setthi/widgets/logo/logoImage.dart';
import 'package:setthi/widgets/logo/logoText.dart';

class LandingScreen extends StatelessWidget {
  // Mock changing page
  final Function login;
  LandingScreen(this.login);

  void _showBottomModal(context, Widget widget, type) {
    showModalBottomSheet(
        context: context,
        barrierColor: kTransparent,
        isScrollControlled: true,
        backgroundColor: kTransparent,
        builder: (ctx) {
          return Wrap(
            children: [_buildBottomModalContainer(widget, type)],
          );
        });
  }

  Widget _buildBottomModalContainer(Widget widget, type) {
    return Container(
      height: type == AuthType.signin ? 350 : 400,
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
        default:
          Navigator.of(context).pop();
      }
    }

    return Scaffold(
        backgroundColor: kGold100,
        body: Container(
          padding: EdgeInsets.symmetric(vertical: kSizeS, horizontal: kSizeM),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              CustomDivider(),
              SecondaryButton(
                  text: "REGISTER",
                  onPressed: () {
                    _showBottomModal(
                        context,
                        RegisterForm(changeModal: _changeModal),
                        AuthType.register);
                  }),
            ],
          ),
        ));
  }
}
