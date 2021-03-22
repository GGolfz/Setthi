import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool isLoading;
  final bool isDisabled;
  SecondaryButton(
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
      splashColor: kGold200,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: kSizeXS,
          horizontal: kSizeM,
        ),
        child: Text(text,
            textAlign: TextAlign.center,
            style: GoogleFonts.quicksand(
                fontSize: kSizeS * 1.25, color: kGold500)),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration(BuildContext context) {
    return BoxDecoration(
      color: kNeutralWhite,
      border: Border.all(color: kGold500),
      borderRadius: kBorderRadiusM,
    );
  }
}
