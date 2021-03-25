import 'package:flutter/material.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/config/style.dart';
import 'package:setthi/utils/format.dart';

class BalanceBox extends StatelessWidget {
  final double balance;
  final String currency;
  BalanceBox({this.balance, this.currency});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        kSizedBoxVerticalS,
        Text('Balance', style: kHeadline2Black),
        kSizedBoxVerticalS,
        Text(
          "$currency ${formatCurrencyString(balance)}",
          style: kHeadline1Black,
        ),
        kSizedBoxVerticalS,
      ],
    );
  }
}
