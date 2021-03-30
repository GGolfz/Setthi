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
          suffixIcon:Icon(
            Icons.calendar_today,
            color: kGold400,
          ),
          filled: true,
          fillColor: kNeutral100,
          enabled: false,
          hintText:
              dateTime == null ? title : DateFormat.yMMMd().format(dateTime),
          contentPadding: EdgeInsets.symmetric(
            horizontal: kSizeS * 1.25,vertical: kSizeS
          ),
        ),
      ),
      onTap: () {
        showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2001),
            lastDate: DateTime(2022),
            errorFormatText: 'Enter valid date',
            errorInvalidText: 'Enter date in valid range',
            fieldHintText: 'Month/Date/Year',
            fieldLabelText: 'Booking date',
            ).then((date) {
          if (date == null) {
            return;
          }
          getDateTime(date);
        });
      },
    );
  }
}
