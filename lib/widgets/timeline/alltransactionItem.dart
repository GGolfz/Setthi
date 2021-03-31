import 'package:flutter/material.dart';
import '../../config/color.dart';
import '../../config/constants.dart';
import '../../config/style.dart';
import '../../model/item.dart';

class TransactionItem extends StatelessWidget {
  final Item item;
  TransactionItem({@required this.item});

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
              height: kSizeM * 1.6,
              width: kSizeM * 1.6,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(kSizeXS * 1.4),
                  ),
                  color: kRed100),
            ),
            title: Text(item.displayName, style: kSubtitle1Black),
            subtitle: Text(item.category.toString(), style: kSubtitle2Black),
            trailing: Text("- THB ${item.price}", style: kHeadline4Red),
          ),
        ));
  }
}
