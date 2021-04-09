import 'package:flutter/material.dart';
import '../../config/constants.dart';
import '../../config/style.dart';

class CategoryItem extends StatelessWidget {
  final String categoryText;
  final String categoryKey;
  final Color categoryColor;
  final Function onTap;
  CategoryItem({this.categoryKey,this.categoryColor, this.categoryText, this.onTap});
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
              color: categoryColor)),
      title: Text(
        categoryText,
        style: kSubtitle1Black,
      ),
      trailing: Icon(Icons.edit),
      onTap: onTap,
    );
  }
}
