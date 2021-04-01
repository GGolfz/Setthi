import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/style.dart';
import '../../utils/format.dart';
import '../layout/customDialog.dart';
import '../../widgets/form/customerEdit.dart';
import '../layout/customDialog.dart';
import '../../provider/savingProvider.dart';
import '../layout/customDialog.dart';

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
      margin: EdgeInsets.all(10),
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
                    content: CustomerEdit(
                  selectedSaving: widget.item,
                ));
              },
            )
          ]),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                'THB 0',
                style: kHeadline4Green,
              ),
              SizedBox(width: 15),
              Text(
                'of THB ${formatCurrencyString(widget.item.savingGoal)}',
                style: kBody1Black.copyWith(color: kNeutral300),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: kNeutral150,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(children: [
                SizedBox(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: kGold500,
                    ),
                    height: double.infinity,
                  ),
                  height: 25,
                )
              ])),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.item.startDay,
                style: kBody1Black.copyWith(color: kNeutral300),
              ),
              Text(
                widget.item.endDay,
                style: kBody1Black.copyWith(color: kNeutral300),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
