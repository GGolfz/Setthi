import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/config/style.dart';
import '../../utils/format.dart';
import '../layout/customDialog.dart';
import 'savingEditForm.dart';
import '../../provider/savingProvider.dart';

class SavingItem extends StatefulWidget {
  final Saving item;
  SavingItem({@required this.item});
  @override
  _SavingItemState createState() => _SavingItemState();
}

class _SavingItemState extends State<SavingItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(kSizeXS),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              widget.item.title,
              style: kHeadline4Black,
            ),
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                showCustomDialog(
                    context: context,
                    content: SavingEditForm(
                      selectedSaving: widget.item,
                    ));
              },
            )
          ]),
          kSizedBoxVerticalXXS,
          Row(
            children: [
              Text(
                'THB ${formatCurrencyString(widget.item.currentAmount)}',
                style: kHeadline4Green,
              ),
              kSizedBoxHorizontalXS,
              Text(
                'of THB ${formatCurrencyString(widget.item.targetAmount)}',
                style: kBody1Black.copyWith(color: kNeutral300),
              ),
            ],
          ),
          kSizedBoxVerticalXXS,
          Container(
            width: double.infinity,
            child: ClipRRect(
                borderRadius: kBorderRadiusS,
                clipBehavior: Clip.hardEdge,
                child: LinearProgressIndicator(
                  //color: kGold500,
                  value: widget.item.currentPercent,
                  backgroundColor: kNeutral150,
                  minHeight: 25,
                )),
          ),
          kSizedBoxVerticalXS,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatDate(widget.item.startDay),
                style: kBody1Black.copyWith(color: kNeutral300),
              ),
              Text(
                formatDate(widget.item.endDay),
                style: kBody1Black.copyWith(color: kNeutral300),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
