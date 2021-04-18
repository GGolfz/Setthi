import 'package:flutter/material.dart';
import '../../config/color.dart';
import '../../config/constants.dart';
import '../../config/style.dart';
import '../../model/transactionType.dart';

class TransactionTypeItem extends StatelessWidget {
  final String label;
  final TransactionType type;
  final bool isCurrent;
  TransactionTypeItem({this.label, this.isCurrent, this.type});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: isCurrent ? 38 : 36,
      child: Center(
          child: Text(
        label,
        style: kSubtitle2Black.copyWith(
            color: isCurrent ? kNeutralWhite : kNeutral350,
            fontWeight: isCurrent ? FontWeight.w600 : FontWeight.w400),
      )),
      decoration: BoxDecoration(
          color: isCurrent ? kGold300 : kNeutral100,
          borderRadius: kBorderRadiusS),
    );
  }
}
