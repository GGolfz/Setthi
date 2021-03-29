import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/config/style.dart';

class SettingItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final String routeName;
  SettingItem({this.icon, this.text, this.routeName});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
          padding: EdgeInsets.all(kSizeXS),
          child: Icon(
            icon,
            color: kGold400,
          )),
      title: Text(
        text,
        style: kHeadline4Black,
      ),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        Navigator.of(context).pushNamed(routeName);
      },
    );
  }
}
