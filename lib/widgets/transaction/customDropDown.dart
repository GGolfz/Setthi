import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:setthi/config/style.dart';
import 'package:setthi/provider/categoryProvider.dart';

class CustomDropDown extends StatelessWidget {
  final String title;
  final dynamic currentValue;
  final List<dynamic> items;
  final Function onChanged;
  CustomDropDown(
      {@required this.title,
      @required this.currentValue,
      @required this.items,
      @required this.onChanged});
  String getTitle(dynamic el) {
    if (el is Category) return el.name;
    return el.title;
  }

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
                      getTitle(element),
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
