import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/config/style.dart';
import 'package:setthi/model/transactionType.dart';

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
