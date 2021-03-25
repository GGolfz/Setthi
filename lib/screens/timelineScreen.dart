import 'package:flutter/material.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/config/style.dart';
import 'package:setthi/modal/item.dart';
import 'package:setthi/widgets/timeline/balanceBox.dart';
import 'package:setthi/widgets/timeline/transactionItem.dart';
import '../config/color.dart';

class TimelineScreen extends StatefulWidget {
  static final routeName = '/timeline';
  TimelineScreen({Key key}) : super(key: key);

  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  List<Item> _items = [
    Item("Food & Drink", "Today, 10.34 AM", 320),
    Item("Food & Drink", "Today, 10.34 AM", 320),
    Item("Food & Drink", "Today, 10.34 AM", 320),
    Item("Food & Drink", "Today, 10.34 AM", 320),
    Item("Food & Drink", "Today, 10.34 AM", 320),
    Item("Food & Drink", "Today, 10.34 AM", 320),
    Item("Food & Drink", "Today, 10.34 AM", 320),
    Item("Food & Drink", "Today, 10.34 AM", 320),
    Item("Food & Drink", "Today, 10.34 AM", 320),
    Item("Food & Drink", "Today, 10.34 AM", 320),
    Item("Food & Drink", "Today, 10.34 AM", 320)
  ];
  ScrollController _scrollController;
  @override
  void initState() {
    super.initState();

    _scrollController = new ScrollController();
  }

  Widget build(BuildContext context) {
    Widget itemsWidget = new ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        controller: _scrollController,
        children: _items.map((Item item) {
          print(item);
          return TransactionItem(item: item);
        }).toList());
    return Scaffold(
      backgroundColor: kGold100,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin:
                  EdgeInsets.symmetric(vertical: kSizeS, horizontal: kSizeM),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [BalanceBox(balance: 1457800, currency: "THB")],
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
                    child: Text('View All', style: kSubtitle1Black),
                  )
                ],
              ),
            ),
            Expanded(
              child: itemsWidget,
            ),
          ],
        ),
      ),
    );
  }
}
