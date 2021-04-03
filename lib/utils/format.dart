import 'package:intl/intl.dart';

String formatCurrencyString(double money) {
  return NumberFormat.currency(locale: "th_TH", symbol: "").format(money);
}

String formatDate(DateTime date) {
  return DateFormat.yMMMMd().format(date);
}
