import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';

String formatCurrencyString(double money) {
  return NumberFormat.currency(locale: "th_TH", symbol: "").format(money);
}
