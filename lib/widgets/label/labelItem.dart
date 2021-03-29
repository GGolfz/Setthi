import 'package:flutter/material.dart';
import 'package:setthi/config/style.dart';

class LabelItem extends StatelessWidget {
  final String labelText;
  final String labelKey;
  LabelItem({this.labelKey, this.labelText});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        labelText,
        style: kSubtitle1Black,
      ),
      trailing: Icon(Icons.edit),
      onTap: () {},
    );
  }
}
