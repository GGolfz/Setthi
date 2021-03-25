import 'package:flutter/foundation.dart';

class Budget {
  final String title;
  final double maxBudget;
  final String startDay;
  final String endDay;
  Budget({
    @required this.title,
    @required this.maxBudget,
    @required this.startDay,
    @required this.endDay,
  });
}
