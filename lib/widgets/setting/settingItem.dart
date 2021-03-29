import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/config/style.dart';

class SettingItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final String routeName;
  final int amount;
  SettingItem({this.icon, this.text, this.routeName, this.amount});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        icon,
        color: kGold400,
      ),
      title: Text(
        text,
        style: kHeadline4Black,
      ),
      trailing: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(
                text: "$amount",
                style: kSubtitle2Black.copyWith(color: kNeutral450)),
            WidgetSpan(
                child: Icon(
                  Icons.chevron_right,
                ),
                baseline: TextBaseline.alphabetic,
                alignment: PlaceholderAlignment.middle)
          ])),
      onTap: () {
        Navigator.of(context).pushNamed(routeName);
      },
    );
  }
}
