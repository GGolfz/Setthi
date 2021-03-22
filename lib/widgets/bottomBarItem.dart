import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';

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
    return MaterialButton(
      minWidth: 50,
      onPressed: () => changeTab(tab),
      child: Column(
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
