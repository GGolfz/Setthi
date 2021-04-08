import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/provider/transactionProvider.dart';
import '../widgets/layout/appBar.dart';
import '../widgets/timeline/alltransactionItem.dart';

class TransactionScreen extends StatefulWidget {
  static const routeName = '/transactions';
  TransactionScreen({Key key}) : super(key: key);

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  DateTime currentDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }

  List<TransactionItem> _items = [];
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
        children: _items.map((TransactionItem item) {
          return AllTransactionItem(item: item);
        }).toList());
    return Scaffold(
      backgroundColor: kGold100,
      appBar: SetthiAppBar(
        title: 'All Transactions',
        leading: BackButton(),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Flexible(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20),
                            filled: true,
                            fillColor: kNeutral100,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15.0)),
                            hintText: 'Search'),
                      ),
                    ),
                  ),
                ),
                Container(
                    child: IconButton(
                  icon: const Icon(Icons.calendar_today_rounded),
                  onPressed: () => _selectDate(context),
                )),
              ],
            ),
          ),
          Expanded(
            child: itemsWidget,
          ),
        ],
      ),
    );
  }
}
