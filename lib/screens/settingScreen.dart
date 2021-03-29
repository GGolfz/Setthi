import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/provider/authenicateProvider.dart';
import 'package:setthi/screens/categoryScreen.dart';
import 'package:setthi/screens/labelScreen.dart';
import 'package:setthi/widgets/buttons/actionButton.dart';
import 'package:setthi/widgets/layout/appBar.dart';
import 'package:setthi/widgets/setting/settingItem.dart';

class SettingScreen extends StatelessWidget {
  static final routeName = '/setting';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SetthiAppBar(
          title: 'Setting',
        ),
        body: Container(
            child: Column(children: [
          Container(
              height: 510,
              child: ListView(
                children: [
                  SettingItem(
                    icon: Icons.label,
                    text: "Labels",
                    routeName: LabelScreen.routeName,
                  ),
                  SettingItem(
                    icon: Icons.category,
                    text: "Categories",
                    routeName: CategoryScreen.routeName,
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.all(kSizeM),
              child: ActionButton(
                text: "Log Out",
                onPressed: () {
                  Provider.of<AuthenticateProvider>(context, listen: false)
                      .logout();
                },
                isFullWidth: true,
                isOutlined: true,
                color: kGold400,
              ))
        ])));
  }
}
