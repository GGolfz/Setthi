import 'package:flutter/material.dart';
import 'savingEditForm.dart';
import '../layout/customDialog.dart';
import '../../config/color.dart';
import '../../config/constants.dart';
import '../../config/style.dart';
import '../../provider/savingProvider.dart';
import '../../utils/format.dart';

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
                  value: widget.item.currentPercent,
                  color: kGold500,
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
                style: kBody1Black.copyWith(
                    color: DateTime.now().isAfter(widget.item.endDay) &&
                            !widget.item.isFinish
                        ? kRed200
                        : kNeutral300),
              ),
              Text(
                formatDate(widget.item.endDay),
                style: kBody1Black.copyWith(
                    color: DateTime.now().isAfter(widget.item.endDay) &&
                            !widget.item.isFinish
                        ? kRed200
                        : kNeutral300),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
