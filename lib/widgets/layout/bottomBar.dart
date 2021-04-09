import 'package:flutter/material.dart';
import '../layout/bottomBarItem.dart';
import '../../config/constants.dart';
import '../../config/color.dart';
import '../../screens/savingScreen.dart';
import '../../screens/settingScreen.dart';
import '../../screens/timelineScreen.dart';
import '../../screens/walletScreen.dart';

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
      'tab': SavingScreen.routeName,
      'blank': false
    },
    {'icon': Icons.more_horiz, 'tab': SettingScreen.routeName, 'blank': false}
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
