import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/config/style.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool isLoading;
  final bool isDisabled;
  PrimaryButton(
      {@required this.text,
      @required this.onPressed,
      this.isLoading,
      this.isDisabled = false});
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Ink(
        width: double.infinity,
        decoration: _buildBoxDecoration(context),
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return InkWell(
      borderRadius: kBorderRadiusM,
      onTap: !isDisabled ? onPressed : null,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: kSizeXS,
          horizontal: kSizeM,
        ),
        child: Text(text, textAlign: TextAlign.center, style: kHeadline4White),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration(BuildContext context) {
    return BoxDecoration(
      color: kGold500,
      borderRadius: kBorderRadiusM,
    );
  }
}
