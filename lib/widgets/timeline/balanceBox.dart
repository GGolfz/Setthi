import 'package:flutter/material.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/config/style.dart';

class BalanceBox extends StatelessWidget {
  final double balance;
  final String currency;
  BalanceBox({this.balance, this.currency});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: kSizeM, bottom: kSizeS),
          child: Column(
            children: [
              Text('Balance', style: kHeadline2Black),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: kSizeS),
          child: Text("$currency $balance", style: kHeadline1Black),
        ),
      ],
    );
  }
}
