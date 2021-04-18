import 'package:flutter/material.dart';
import 'sourceList.dart';
import '../../config/color.dart';
import '../../config/constants.dart';
import '../../config/style.dart';
import '../../utils/format.dart';

class SourceListItem extends StatelessWidget {
  final SourceItem source;
  final bool isSelect;
  SourceListItem({this.source, this.isSelect});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(kSizeXS),
      padding: EdgeInsets.all(kSizeXXS),
      width: 160,
      height: 85,
      decoration: BoxDecoration(
          color: isSelect ? kGold300Fade : kNeutral100,
          border: isSelect ? Border.all(color: kGold300, width: 2) : null),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            source.title,
            style: kBody1Black.copyWith(
                fontWeight: FontWeight.w600, color: kNeutral450),
          ),
          Text(
            '(${source.sourceLabel})',
            style: kBody1Black.copyWith(
                fontWeight: FontWeight.w600, color: kNeutral350),
          ),
          Text(
            'THB ${formatCurrencyString(source.amount)}',
            style: kSubtitle2Black.copyWith(
                color: kNeutralBlack, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
