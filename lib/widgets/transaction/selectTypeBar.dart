import 'package:flutter/material.dart';
import 'transactionTypeItem.dart';
import '../../config/color.dart';
import '../../config/constants.dart';
import '../../model/transactionType.dart';

class SelectTypeBar extends StatelessWidget {
  final TransactionType current;
  final Function onChange;
  final types = [
    {"label": "Income", "type": TransactionType.Income},
    {"label": "Expense", "type": TransactionType.Expense},
    {"label": "Saving", "type": TransactionType.Saving}
  ];
  SelectTypeBar({@required this.current, @required this.onChange});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 36,
      decoration:
          BoxDecoration(color: kNeutral100, borderRadius: kBorderRadiusS),
      child: Row(
        children: [
          ...types
              .map((type) => Expanded(
                      child: GestureDetector(
                    child: TransactionTypeItem(
                      label: type["label"],
                      type: type["type"],
                      isCurrent: current == type["type"],
                    ),
                    onTap: () => onChange(type["type"]),
                  )))
              .toList(),
        ],
      ),
    );
  }
}
