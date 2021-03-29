import 'package:flutter/material.dart';
import '../../config/color.dart';
import '../../config/constants.dart';
import '../../config/style.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool isLoading;
  final bool isDisabled;
  final bool isDark;
  SecondaryButton(
      {@required this.text,
      @required this.onPressed,
      this.isLoading,
      this.isDisabled = false,
      this.isDark = true});
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
      splashColor: kGold200,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: kSizeXS,
          horizontal: kSizeM,
        ),
        child: Text(text,
            textAlign: TextAlign.center,
            style: isDark ? kHeadline4White : kHeadline4Black),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration(BuildContext context) {
    return BoxDecoration(
      color: kTransparent,
      border: Border.all(color: kGold500),
      borderRadius: kBorderRadiusM,
    );
  }
}
