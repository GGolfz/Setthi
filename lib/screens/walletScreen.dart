import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/wallet/walletCard.dart';
import '../provider/walletProvider.dart';
import '../widgets/layout/appBar.dart';
import '../widgets/wallet/emptyWallet.dart';
import '../widgets/layout/customDialog.dart';
import '../widgets/buttons/actionButton.dart';
import '../widgets/wallet/newWalletForm.dart';
import '../utils/format.dart';
import '../config/constants.dart';
import '../config/color.dart';

class WalletScreen extends StatelessWidget {
  static final routeName = '/wallet';
  Widget _buildButtonCreate(BuildContext context) {
    return Center(
      child: Container(
        margin:
            EdgeInsets.symmetric(horizontal: kSizeM * 1.8, vertical: kSizeS),
        child: ActionButton(
          text: "Create a new wallet",
          onPressed: () {
            showCustomDialog(context: context, content: NewWalletForm());
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final wallet = Provider.of<WalletProvider>(context);
    return Scaffold(
      backgroundColor: kGold100,
      appBar: SetthiAppBar(
        title: 'THB ${formatCurrencyString(wallet.totalAmount)}',
        subtitle: 'Total Wealth',
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: kSizeS, vertical: kSizeXS),
          child: Column(
            children: <Widget>[
              Container(
                child: Text('This is graph'),
                height: 150,
              ),
              if (wallet.isEmpty()) EmptyWallet(),
              Container(
                height: 375,
                child: ListView.builder(
                  itemBuilder: (ctx, index) =>
                      WalletCard(item: wallet.wallets[index]),
                  itemCount: wallet.walletCount,
                ),
              ),
              _buildButtonCreate(context),
            ],
          ),
        ),
      ),
    );
  }
}
