import 'package:flutter/material.dart';
import '../config/color.dart';
import '../config/constants.dart';
import '../modal/authType.dart';
import '../widgets/auth/registerForm.dart';
import '../widgets/auth/signinForm.dart';
import '../widgets/buttons/primaryButton.dart';
import '../widgets/buttons/secondaryButton.dart';
import '../widgets/landing/descriptionText.dart';
import '../widgets/layout/customDivider.dart';
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
          return Wrap(
            children: [_buildBottomModalContainer(widget, type)],
          );
        });
  }

  Widget _buildBottomModalContainer(Widget widget, type) {
    return Container(
      height: type == AuthType.signin ? 380 : 400,
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
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.symmetric(vertical: kSizeS, horizontal: kSizeM),
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              kSizedBoxVerticalXL,
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
          )),
        ));
  }
}
