import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/style.dart';
import 'package:setthi/model/labelType.dart';

class LabelTypeSelect extends StatelessWidget {
  final String text;
  final LabelType type;
  final LabelType current;
  final Function changeStatus;
  LabelTypeSelect({this.text, this.type, this.current, this.changeStatus});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: current == type
              ? kHeadline3Black.copyWith(fontSize: 18, color: kNeutralBlack)
              : kHeadline4Black.copyWith(fontSize: 16, color: kNeutral450),
        ),
        onTap: () => changeStatus(type),
      ),
    );
  }
}
