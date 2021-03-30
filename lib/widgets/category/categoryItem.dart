import 'package:flutter/material.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/config/style.dart';

class CategoryItem extends StatelessWidget {
  final String categoryText;
  final String categoryKey;
  final Function onTap;
  CategoryItem({this.categoryKey, this.categoryText, this.onTap});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
          margin: EdgeInsets.all(kSizeS),
          height: kSizeS,
          width: kSizeS,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(kSizeXXS),
              ),
              color: Colors.green)),
      title: Text(
        categoryText,
        style: kSubtitle1Black,
      ),
      trailing: Icon(Icons.edit),
      onTap: onTap,
    );
  }
}
