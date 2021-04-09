import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setthi/model/httpException.dart';
import '../config/style.dart';
import '../widgets/wallet/emptyWallet.dart';
import '../widgets/wallet/walletCard.dart';
import '../provider/walletProvider.dart';
import '../widgets/layout/appBar.dart';
import '../widgets/layout/customDialog.dart';
import '../widgets/buttons/actionButton.dart';
import '../widgets/wallet/newWalletForm.dart';
import '../widgets/wallet/editWalletForm.dart';
import '../widgets/wallet/expenseChart.dart';
import '../utils/format.dart';
import '../config/constants.dart';
import '../config/color.dart';
import '../widgets/layout/errorDialog.dart';

class WalletScreen extends StatefulWidget {
  static final routeName = '/wallet';

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
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

  void onClickEdit(BuildContext context, WalletItem selectedWallet) {
    showCustomDialog(
      context: context,
      content: EditWalletForm(selectedWallet: selectedWallet),
    );
  }

  @override
  void initState() {
    fetchWallet();
    super.initState();
  }

  void fetchWallet() async {
    try {
      await Provider.of<WalletProvider>(context, listen: false).fetchWallet();
      await Provider.of<WalletProvider>(context, listen: false)
          .fetchExpenseChart();
    } on HttpException catch (error) {
      showErrorDialog(
          context: context,
          text: error.message,
          isNetwork: error.isInternetProblem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WalletProvider>(
        builder: (ctx, wallet, _) => Scaffold(
              backgroundColor: kGold100,
              appBar: SetthiAppBar(
                title: 'THB ${formatCurrencyString(wallet.totalAmount)}',
                subtitle: 'Total Wealth',
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: kSizeS, vertical: kSizeXS),
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: [
                          Text('Your expense', style: kHeadline3Black),
                          kSizedBoxVerticalXXS,
                          Container(
                            child: ExpenseChart(),
                            height: 170,
                          )
                        ],
                      ),
                      kSizedBoxVerticalS,
                      wallet.isEmpty()
                          ? EmptyWallet()
                          : Container(
                              height: 310,
                              child: ListView.builder(
                                itemBuilder: (ctx, index) => WalletCard(
                                  item: wallet.wallets[index],
                                  onTap: () => onClickEdit(
                                      context, wallet.wallets[index]),
                                ),
                                itemCount: wallet.walletCount,
                              ),
                            ),
                      _buildButtonCreate(context),
                    ],
                  ),
                ),
              ),
            ));
  }
}
