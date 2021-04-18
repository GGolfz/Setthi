import 'package:flutter/material.dart';
import '../../config/constants.dart';
import '../../config/style.dart';
import '../../utils/format.dart';

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
        Container(
          child: FittedBox(
              child: Text(
                "$currency ${formatCurrencyString(balance)}",
                style: kHeadline1Black,
              ),
              fit: BoxFit.fitWidth),
          width: MediaQuery.of(context).size.width * 0.7,
        ),
        kSizedBoxVerticalS,
      ],
    );
  }
}
