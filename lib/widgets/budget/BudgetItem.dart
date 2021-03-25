import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';
import 'package:google_fonts/google_fonts.dart';

class BudgetItem extends StatefulWidget {
  final String title;
  final int maxBudget;
  final String startDay;
  final String finalDay;
  BudgetItem(this.title, this.maxBudget, this.startDay, this.finalDay);
  @override
  _BudgetItemState createState() => _BudgetItemState();
}

class _BudgetItemState extends State<BudgetItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: GoogleFonts.quicksand(fontSize: 20),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                'THB 0',
                style: GoogleFonts.quicksand(fontSize: 20, color: kGreen500),
              ),
              SizedBox(width: 15),
              Text(
                'of THB ${widget.maxBudget}',
                style: GoogleFonts.quicksand(fontSize: 15, color: kNeutral300),
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
                style: GoogleFonts.quicksand(color: kNeutral300),
              ),
              Text(
                widget.finalDay,
                style: GoogleFonts.quicksand(color: kNeutral300),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
