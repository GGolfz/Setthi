import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/color.dart';
import '../config/constants.dart';
import '../config/style.dart';
import '../model/httpException.dart';
import '../provider/transactionProvider.dart';
import '../provider/walletProvider.dart';
import '../screens/transactionScreen.dart';
import '../widgets/layout/errorDialog.dart';
import '../widgets/timeline/balanceBox.dart';
import '../widgets/timeline/transactionItemBox.dart';

class TimelineScreen extends StatefulWidget {
  static final routeName = '/timeline';
  TimelineScreen({Key key}) : super(key: key);

  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  ScrollController _scrollController;
  @override
  void initState() {
    try {
      Provider.of<WalletProvider>(context, listen: false).fetchWallet();
      Provider.of<TransactionProvider>(context, listen: false)
          .fetchTransaction();
    } on HttpException catch (error) {
      showErrorDialog(
          context: context,
          text: error.message,
          isNetwork: error.isInternetProblem);
    }
    _scrollController = new ScrollController();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGold100,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin:
                  EdgeInsets.symmetric(vertical: kSizeS, horizontal: kSizeM),
              child: Consumer<WalletProvider>(
                builder: (ctx, wallet, _) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BalanceBox(balance: wallet.totalAmount, currency: "THB")
                  ],
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(kSizeS),
                ),
                color: kGold200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: kSizeS, horizontal: kSizeS * 1.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Transactions', style: kHeadline3Black),
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: GestureDetector(
                      child: Text('View All', style: kSubtitle1Black),
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(TransactionScreen.routeName);
                      },
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Consumer<TransactionProvider>(
                  builder: (ctx, transaction, _) => transaction
                          .transactions.isNotEmpty
                      ? ListView(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          controller: _scrollController,
                          children: transaction.transactions.map((transaction) {
                            return TransactionItemBox(item: transaction);
                          }).toList())
                      : Column(children: [
                          SizedBox(
                            height: 200,
                            child: Image.asset(
                              "assets/images/empty-transaction.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                          Text(
                            "No transaction",
                            style: kSubtitle1Black,
                          )
                        ])),
            ),
          ],
        ),
      ),
    );
  }
}
