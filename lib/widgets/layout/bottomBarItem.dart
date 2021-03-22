import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';

class BottomBarItem extends StatelessWidget {
  final IconData icon;
  final bool isCurrent;
  final Function changeTab;
  final String tab;
  BottomBarItem({
    @required this.icon,
    @required this.tab,
    @required this.isCurrent,
    @required this.changeTab,
  });
  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: kSizeS * 1.6,
      onPressed: () => changeTab(tab),
      icon: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isCurrent ? kGold200 : kNeutralWhite,
          )
        ],
      ),
    );
  }
}
