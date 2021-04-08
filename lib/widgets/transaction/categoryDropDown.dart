import 'package:flutter/material.dart';
import 'package:setthi/config/style.dart';
import 'package:setthi/provider/categoryProvider.dart';

class CategoryDropDown extends StatelessWidget {
  final String title;
  final Category currentValue;
  final List<Category> items;
  final Function onChanged;
  CategoryDropDown(
      {@required this.title,
      @required this.currentValue,
      @required this.items,
      @required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: kSubtitle2Black.copyWith(fontWeight: FontWeight.w600),
        ),
        DropdownButtonFormField(
          value: currentValue,
          items: items
              .map((element) => DropdownMenuItem(
                    child: Text(
                      element.name,
                      style:
                          kSubtitle2Black.copyWith(fontWeight: FontWeight.w600),
                    ),
                    value: element,
                  ))
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(contentPadding: EdgeInsets.zero),
        )
      ],
    );
  }
}
