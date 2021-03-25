import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/config/style.dart';

class BudgetDatePicker extends StatelessWidget {
  final String title;
  final Function getDateTime;
  final DateTime dateTime;
  BudgetDatePicker(
      {@required this.title,
      @required this.getDateTime,
      @required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: TextFormField(
        style: kBody1Gold,
        decoration: InputDecoration(
          icon: Icon(
            Icons.calendar_today,
            color: kGold400,
          ),
          border: OutlineInputBorder(
              borderRadius: kBorderRadiusXS * 1.5, borderSide: BorderSide.none),
          filled: true,
          fillColor: kNeutralWhite,
          enabled: false,
          hintText:
              dateTime == null ? title : DateFormat.yMMMd().format(dateTime),
          hintStyle: kBody1Gold,
          contentPadding: EdgeInsets.symmetric(
            horizontal: kSizeS * 1.25,
          ),
        ),
      ),
      onTap: () {
        showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2001),
                lastDate: DateTime(2022))
            .then((date) {
          if (date == null) {
            return;
          }
          getDateTime(date);
        });
      },
    );
  }
}
