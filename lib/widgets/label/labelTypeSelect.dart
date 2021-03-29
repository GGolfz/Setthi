import 'package:flutter/material.dart';
import 'package:setthi/config/style.dart';
import 'package:setthi/model/labelStatus.dart';

class LabelTypeSelect extends StatelessWidget {
  final String text;
  final LabelStatus type;
  final LabelStatus current;
  final Function changeStatus;
  LabelTypeSelect({this.text, this.type, this.current, this.changeStatus});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: current == type ? kHeadline3Black : kHeadline4Black,
        ),
        onTap: () => changeStatus(type),
      ),
    );
  }
}
