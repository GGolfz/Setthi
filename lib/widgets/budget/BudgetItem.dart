import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/style.dart';
import '../../utils/format.dart';

class BudgetItem extends StatefulWidget {
  final String title;
  final double maxBudget;
  final String startDay;
  final String finalDay;
  BudgetItem(this.title, this.maxBudget, this.startDay, this.finalDay);
  @override
  _BudgetItemState createState() => _BudgetItemState();
}

class _BudgetItemState extends State<BudgetItem> {
  String getDisplayMaxBudget() {}
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      // width: MediaQuery.of(context).size.width * 0.9,
      // height: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: kHeadline4Black,
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                'THB 0',
                style: kHeadline4Green,
              ),
              SizedBox(width: 15),
              Text(
                'of THB ${formatCurrencyString(widget.maxBudget)}',
                style: kBody1Black.copyWith(color: kNeutral300),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: kNeutral150,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(children: [
                SizedBox(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: kGold500,
                    ),
                    height: double.infinity,
                  ),
                  height: 50,
                )
              ])),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.startDay,
                style: kBody1Black.copyWith(color: kNeutral300),
              ),
              Text(
                widget.finalDay,
                style: kBody1Black.copyWith(color: kNeutral300),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
