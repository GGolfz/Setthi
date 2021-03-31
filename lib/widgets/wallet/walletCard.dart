import 'package:flutter/material.dart';
import '../../provider/walletProvider.dart';
import '../../config/color.dart';
import '../../config/constants.dart';
import '../../config/style.dart';
import '../../utils/format.dart';

class WalletCard extends StatelessWidget {
  final WalletItem item;
  final Function onTap;
  WalletCard({@required this.item, @required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.symmetric(vertical: kSizeXXS * 1.2, horizontal: kSizeS),
      padding: EdgeInsets.all(kSizeXXS),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(kSizeM)),
        color: kNeutral100,
      ),
      child: ListTile(
        leading: Container(
          height: kSizeM * 1.6,
          width: kSizeM * 1.6,
          child: Image.asset("assets/images/account_balance_wallet.png"),
        ),
        title: Text(item.title, style: kSubtitle1Black),
        subtitle: Text('THB ${formatCurrencyString(item.amount)}',
            style: kHeadline3Black),
        trailing: Icon(Icons.edit),
        onTap: onTap,
      ),
    );
  }
}
