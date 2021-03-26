import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';

String formatCurrencyString(double money) {
  return NumberFormat.currency(locale: "th_TH", symbol: "").format(money);
}

String displayDecimal({@required double value, int digit = 2}) {
  String temp = (value).toStringAsFixed(digit);
  List<String> sep = temp.split('.');
  String left = sep[0], right = sep[1], newLeft = "";
  int count = 0;
  for (int i = left.length - 1; i >= 0; i--) {
    count++;
    newLeft = left[i] + newLeft;
    if (count % 3 == 0 && i != 0) newLeft = "," + newLeft;
  }
  return newLeft + "." + right;
}
