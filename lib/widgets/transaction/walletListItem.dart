import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/config/style.dart';
import 'package:setthi/provider/walletProvider.dart';
import '../../utils/format.dart';

class WalletListItem extends StatelessWidget {
  final WalletItem wallet;
  final bool isSelect;
  WalletListItem({this.wallet, this.isSelect});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(kSizeXS),
      padding: EdgeInsets.all(kSizeXXS),
      width: 160,
      height: 50,
      decoration: BoxDecoration(
          color: isSelect ? kGold300Fade : kNeutral100,
          border: isSelect ? Border.all(color: kGold300, width: 2) : null),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            wallet.title,
            style: kBody1Black.copyWith(
                fontWeight: FontWeight.w600, color: kNeutral350),
          ),
          Text(
            'THB ${formatCurrencyString(wallet.amount)}',
            style: kSubtitle2Black.copyWith(
                color: kNeutralBlack, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
