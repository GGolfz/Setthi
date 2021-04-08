import 'package:flutter/material.dart';
import 'package:setthi/model/transactionType.dart';
import 'package:setthi/provider/transactionProvider.dart';
import '../../config/color.dart';
import '../../config/constants.dart';
import '../../config/style.dart';
import 'package:setthi/utils/format.dart';

class TransactionItemBox extends StatelessWidget {
  final TransactionItem item;
  TransactionItemBox({@required this.item});

  Widget _textType(type) {
    switch (type) {
      case TransactionType.Income:
        return
          Text("+ THB ${item.amount}", style: kHeadline4Green);
        break;

      case TransactionType.Expense:
        return
          Text("- THB ${item.amount}", style: kHeadline4Red);
        break;

      default:
        return
          Text("- THB ${item.amount}", style: kHeadline4Red);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin:
            EdgeInsets.symmetric(vertical: kSizeXXS * 1.2, horizontal: kSizeS),
        padding: EdgeInsets.all(kSizeXXS),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(kSizeM)),
          color: kNeutral100,
        ),
        child: ListTile(
          leading: Container(
            height: kSizeM * 1.6,
            width: kSizeM * 1.6,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(kSizeXS * 1.4),
                ),
                color: item.color),
          ),
          title: Text(item.name, style: kSubtitle1Black),
          subtitle: Text("${formatDate(item.date)} (${item.wallet})",
              style: kSubtitle2Black),
          trailing: _textType(item.type),
        ));
  }
}
