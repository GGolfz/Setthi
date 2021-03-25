import 'package:flutter/material.dart';
import 'package:setthi/config/style.dart';
import '../config/color.dart';

const double _ITEM_HEIGHT = 80.0;

class TimelineScreen extends StatefulWidget {
  static final routeName = '/timeline';
  TimelineScreen({Key key}) : super(key: key);

  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  List<Item> _items = [];
  ScrollController _scrollController;
  @override
  void initState() {
    super.initState();

    _scrollController = new ScrollController();

    _items = new List<Item>();
    _items.add(new Item("Food & Drink", "Today, 10.34 AM", 320));
    _items.add(new Item("Food & Drink", "Today, 10.34 AM", 320));
    _items.add(new Item("Food & Drink", "Today, 10.34 AM", 320));
    _items.add(new Item("Food & Drink", "Today, 10.34 AM", 320));
    _items.add(new Item("Food & Drink", "Today, 10.34 AM", 320));
    _items.add(new Item("Food & Drink", "Today, 10.34 AM", 320));
    _items.add(new Item("Food & Drink", "Today, 10.34 AM", 320));
    _items.add(new Item("Food & Drink", "Today, 10.34 AM", 320));
    _items.add(new Item("Food & Drink", "Today, 10.34 AM", 320));
    _items.add(new Item("Food & Drink", "Today, 10.34 AM", 320));
    _items.add(new Item("Food & Drink", "Today, 10.34 AM", 320));
  }

  Widget build(BuildContext context) {
    Widget itemsWidget = new ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        controller: _scrollController,
        children: _items.map((Item item) {
          return _singleItemDisplay(item);
        }).toList());
    return Scaffold(
      backgroundColor: kGold100,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 25.0, bottom: 17.0),
                          child: Column(
                            children: [
                              Text('Balance', style: kHeadline2Black),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40.0),
                          child: Text('145,786', style: kHeadline1Black),
                        ),
                      ],
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  color: kGold200,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 20.0),
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

  Widget _singleItemDisplay(Item item) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      child: new Container(
        height: _ITEM_HEIGHT,
        child: new Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
            color: kNeutral100,
          ),
          padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 5.0, 0.0, 0.0),
                    child: Container(
                      height: 60.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(35.0),
                          ),
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 10.0, 50.0, 10.0),
                    child: Column(
                      children: [
                        Text(item.displayName, style: kSubtitle1Black),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(item.category.toString(), style: kSubtitle2Black),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("- THB ${item.price}", style: kHeadline4Red),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Item {
  final String displayName;
  final String category;
  final int price;
  const Item(this.displayName, this.category, this.price);
}
