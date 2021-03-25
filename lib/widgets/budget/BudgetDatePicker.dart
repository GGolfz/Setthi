import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/config/style.dart';

class BudgetDatePicker extends StatefulWidget {
  final String title;
  Function getDateTime;

  BudgetDatePicker({@required this.title, @required this.getDateTime});
  @override
  _BudgetDatePickerState createState() => _BudgetDatePickerState();
}

class _BudgetDatePickerState extends State<BudgetDatePicker> {
  String _dateTime;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: kBody1Gold,
      decoration: InputDecoration(
        icon: IconButton(
          color: kGold400,
          onPressed: () {
            showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2001),
                    lastDate: DateTime(2022))
                .then((date) {
              setState(() {
                final formatDate = DateFormat.yMMMd().format(date);
                _dateTime = formatDate.toString();
                widget.getDateTime(_dateTime);
              });
            });
          },
          icon: Icon(Icons.calendar_today),
        ),
        border: OutlineInputBorder(
            borderRadius: kBorderRadiusXS * 1.5, borderSide: BorderSide.none),
        filled: true,
        fillColor: kNeutralWhite,
        hintText: _dateTime == null ? widget.title : _dateTime.toString(),
        hintStyle: kBody1Gold,
        contentPadding: EdgeInsets.symmetric(
          horizontal: kSizeS * 1.25,
        ),
      ),
    );
  }
}
