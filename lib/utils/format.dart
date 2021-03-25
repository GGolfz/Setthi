import 'package:intl/intl.dart';

String formatCurrencyString(double money) {
  return NumberFormat.currency(locale: "th_TH", symbol: "").format(money);
}
