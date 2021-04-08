import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/provider/transactionProvider.dart';
import '../widgets/layout/appBar.dart';
import '../widgets/timeline/alltransactionItem.dart';
import '../provider/transactionProvider.dart';

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
    Provider.of<TransactionProvider>(context, listen: false).fetchAllTransactions();
    _scrollController = new ScrollController();
    super.initState();
  }

  Widget build(BuildContext context) {
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
            child: Consumer<TransactionProvider>(
                builder: (ctx, transaction, _) => ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    controller: _scrollController,
                    children: transaction.transactions.map((transaction) {
                      return AllTransactionItem(item: transaction);
                    }).toList()),
              ),
          ),
        ],
      ),
    );
  }
}
