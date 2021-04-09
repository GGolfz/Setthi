import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

String formatCurrencyString(double money) {
  return NumberFormat.currency(locale: "th_TH", symbol: "").format(money);
}

String formatDate(DateTime date) {
  return DateFormat.yMMMMd().format(date);
}

String getWeekDayString(int day) {
  return {
    DateTime.monday: "Mon",
    DateTime.tuesday: "Tue",
    DateTime.wednesday: "Wed",
    DateTime.thursday: "Thu",
    DateTime.friday: "Fri",
    DateTime.saturday: "Sat",
    DateTime.sunday: "Sun"
  }[day];
}

String getColorText(Color color) {
  return "${color.red.toString()}:${color.green.toString()}:${color.blue.toString()}:${color.alpha.toString()}";
}

Color getColorFromText(String colorText) {
  var colorVal = colorText.split(':').map((e) => int.parse(e)).toList();
  return Color.fromARGB(colorVal[3], colorVal[0], colorVal[1], colorVal[2]);
}
