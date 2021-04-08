import 'package:flutter/material.dart';
import 'package:setthi/screens/transactionScreen.dart';
import '../config/color.dart';
import 'package:provider/provider.dart';
import '../config/constants.dart';
import '../config/style.dart';
import '../model/item.dart';
import '../widgets/timeline/balanceBox.dart';
import '../widgets/timeline/transactionItemBox.dart';
import '../provider/transactionProvider.dart';
import '../provider/walletProvider.dart';

class TimelineScreen extends StatefulWidget {
  static final routeName = '/timeline';
  TimelineScreen({Key key}) : super(key: key);

  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  List<Item> _items = [
    Item("Food & Drink", "Today, 10.34 AM (Wallet1)", 320),
    Item("Food & Drink", "Today, 10.34 AM (Wallet1)", 320),
    Item("Food & Drink", "Today, 10.34 AM (Wallet1)", 320),
    Item("Food & Drink", "Today, 10.34 AM (Wallet1)", 320),
    Item("Food & Drink", "Today, 10.34 AM (Wallet1)", 320),
    Item("Food & Drink", "Today, 10.34 AM (Wallet1)", 320),
    Item("Food & Drink", "Today, 10.34 AM (Wallet1)", 320),
    Item("Food & Drink", "Today, 10.34 AM (Wallet1)", 320),
    Item("Food & Drink", "Today, 10.34 AM (Wallet1)", 320),
    Item("Food & Drink", "Today, 10.34 AM (Wallet1)", 320),
    Item("Food & Drink", "Today, 10.34 AM (Wallet1)", 320)
  ];
  ScrollController _scrollController;
  @override
  void initState() {
    Provider.of<WalletProvider>(context, listen: false).fetchWallet();
    Provider.of<TransactionProvider>(context, listen: false).fetchTransaction();
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
                builder: (ctx, transaction, _) => ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    controller: _scrollController,
                    children: transaction.transactions.map((transaction) {
                      return TransactionItemBox(item: transaction);
                    }).toList()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
