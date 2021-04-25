import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setthi/widgets/wallet/circularChart.dart';
import 'package:setthi/widgets/wallet/indicator.dart';
import '../config/constants.dart';
import '../config/color.dart';
import '../config/style.dart';
import '../model/httpException.dart';
import '../provider/walletProvider.dart';
import '../utils/format.dart';
import '../widgets/layout/appBar.dart';
import '../widgets/layout/errorDialog.dart';
import '../widgets/wallet/balanceChart.dart';

class WalletScreen extends StatefulWidget {
  static final routeName = '/wallet';

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
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
      await Provider.of<WalletProvider>(context, listen: false)
          .fetchCategoryChart();
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
                padding:
                    EdgeInsets.symmetric(horizontal: kSizeS, vertical: kSizeXS),
                child: Consumer<WalletProvider>(
                  builder: (ctx, wallet, _) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Weekly statistic', style: kHeadline2Black)
                          ]),
                      Text('Transactions Chart', style: kHeadline3Black),
                      kSizedBoxVerticalXS,
                      Container(
                        child: BalanceChart(),
                        height: MediaQuery.of(context).size.height * 0.22,
                      ),
                      kSizedBoxVerticalXS,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Indicator(
                            text: "Income",
                            color: const Color(0xFF57C84D),
                            alignment: MainAxisAlignment.center,
                          ),
                          Indicator(
                            text: "Expense",
                            color: const Color(0xFFEA4C46),
                            alignment: MainAxisAlignment.center,
                          ),
                        ],
                      ),
                      kSizedBoxVerticalS,
                      Text('Income by category', style: kHeadline3Black),
                      kSizedBoxVerticalXS,
                      CircularChart(wallet.categoryData.income),
                      kSizedBoxVerticalS,
                      Text('Expense by category', style: kHeadline3Black),
                      kSizedBoxVerticalXS,
                      CircularChart(wallet.categoryData.expense),
                    ],
                  ),
                ),
              )),
            ));
  }
}
