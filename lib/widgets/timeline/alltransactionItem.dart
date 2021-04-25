import 'package:flutter/material.dart';
import '../../model/transactionType.dart';
import '../../provider/transactionProvider.dart';
import '../../config/color.dart';
import '../../config/constants.dart';
import '../../config/style.dart';
import '../../utils/format.dart';

class AllTransactionItem extends StatelessWidget {
  final TransactionItem item;
  AllTransactionItem({@required this.item});

  Widget _textType(type) {
    switch (type) {
      case TransactionType.Income:
      case TransactionType.IncomeFromSaving:
        return Text("+ THB ${formatCurrencyString(item.amount)}",
            style: kSubtitle1Green);
        break;
      case TransactionType.Expense:
      case TransactionType.ExpenseFromSaving:
      case TransactionType.Saving:
        return Text("- THB ${formatCurrencyString(item.amount)}",
            style: kSubtitle1Red);
        break;
    }
    return Container();
  }

  Widget _subtitleRow(text) {
    return Row(
      children: [Text("$text", style: kBody1Black)],
      mainAxisAlignment: MainAxisAlignment.start,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: kSizeXS, horizontal: kSizeS),
        padding: EdgeInsets.all(kSizeXXS),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                color: kNeutral250, width: 1, style: BorderStyle.solid),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: ListTile(
              leading: Container(
                height: kSizeM * 1.2,
                width: kSizeM * 1.2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(kSizeXS * 1.4),
                    ),
                    color: item.color),
              ),
              title: Text(item.name,
                  style: kSubtitle1Black.copyWith(fontSize: 18)),
              subtitle: Column(children: [
                _subtitleRow(item.category),
                _subtitleRow(formatDate(item.date))
              ]),
              trailing: Container(
                child: FittedBox(
                    child: _textType(item.type), fit: BoxFit.fitWidth),
                width: 100,
              )),
        ));
  }
}
