import 'package:flutter/material.dart';
import 'package:setthi/screens/budgetScreen.dart';
import 'package:setthi/screens/moreScreen.dart';
import 'package:setthi/screens/timelineScreen.dart';
import 'package:setthi/screens/walletScreen.dart';
import 'package:setthi/widgets/layout/bottomBarItem.dart';
import '../../config/constants.dart';
import '../../config/color.dart';

class BottomBar extends StatelessWidget {
  final String currentTab;
  final Function changeTab;
  BottomBar({@required this.currentTab, @required this.changeTab});
  final barItems = [
    {'icon': Icons.list, 'tab': TimelineScreen.routeName, 'blank': false},
    {
      'icon': Icons.account_balance_wallet,
      'tab': WalletScreen.routeName,
      'blank': false
    },
    {'blank': true},
    {
      'icon': Icons.monetization_on,
      'tab': BudgetScreen.routeName,
      'blank': false
    },
    {'icon': Icons.more_horiz, 'tab': MoreScreen.routeName, 'blank': false}
  ];
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(kSizeM),
        topRight: Radius.circular(kSizeM),
      ),
      child: BottomAppBar(
        notchMargin: kSizeXS,
        color: kNeutral450,
        shape: CircularNotchedRectangle(),
        child: Container(
          height: kSizeL,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...barItems.map((item) {
                if (item["blank"]) {
                  return kSizedBoxHorizontalM;
                }
                return BottomBarItem(
                    icon: item["icon"],
                    tab: item["tab"],
                    isCurrent: item["tab"] == currentTab,
                    changeTab: changeTab);
              })
            ],
          ),
        ),
      ),
    );
  }
}
