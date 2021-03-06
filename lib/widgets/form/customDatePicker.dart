import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../config/color.dart';
import '../../config/constants.dart';
import '../../config/style.dart';

class CustomDatePicker extends StatelessWidget {
  final String title;
  final Function getDateTime;
  final DateTime dateTime;
  CustomDatePicker(
      {@required this.title,
      @required this.getDateTime,
      @required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        title,
        style: kSubtitle2Black.copyWith(fontWeight: FontWeight.w600),
      ),
      kSizedBoxVerticalXXS,
      GestureDetector(
        child: TextFormField(
          style: kBody1Gold,
          validator: (value) {
            if (dateTime == null) return 'Please enter ${title.toLowerCase()}';
            return null;
          },
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.calendar_today,
              color: kGold400,
            ),
            filled: true,
            fillColor: kNeutral100,
            enabled: false,
            labelStyle: kBody2Black,
            errorStyle: kBody2Red,
            hintText: '   ' +
                (dateTime == null
                    ? title
                    : DateFormat.yMMMd().format(dateTime)),
            contentPadding: EdgeInsets.only(top: kSizeS),
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
      )
    ]);
  }
}
