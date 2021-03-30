import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/style.dart';
import 'package:setthi/model/categoryStatus.dart';

class CategoryTypeSelect extends StatelessWidget {
  final String text;
  final CategoryStatus type;
  final CategoryStatus current;
  final Function changeStatus;
  CategoryTypeSelect({this.text, this.type, this.current, this.changeStatus});
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
