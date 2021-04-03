import 'package:flutter/material.dart';
import '../../config/color.dart';
import '../../config/constants.dart';
import '../../config/style.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool isLoading;
  final bool isDisabled;
  PrimaryButton(
      {@required this.text,
      @required this.onPressed,
      this.isLoading = false,
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
      onTap: isDisabled || isLoading ? null : onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: kSizeXS,
          horizontal: kSizeM,
        ),
        child: isLoading
            ? SizedBox(
                height: 25,
                child: FittedBox(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                ),
              )
            : Text(text, textAlign: TextAlign.center, style: kHeadline4White),
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
