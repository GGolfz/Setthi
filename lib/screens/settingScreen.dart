import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/config/style.dart';
import 'package:setthi/provider/authenicateProvider.dart';
import 'package:setthi/screens/categoryScreen.dart';
import 'package:setthi/screens/labelScreen.dart';
import 'package:setthi/widgets/buttons/actionButton.dart';
import 'package:setthi/widgets/layout/appBar.dart';
import 'package:setthi/widgets/layout/divider.dart';
import 'package:setthi/widgets/setting/settingItem.dart';

class SettingScreen extends StatelessWidget {
  static final routeName = '/setting';
  Future<String> getVersionNumber() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final version = packageInfo.version;
    final buildNumber = packageInfo.buildNumber;
    return '$version ($buildNumber)';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SetthiAppBar(
          title: 'Setting',
        ),
        body: Container(
            padding: EdgeInsets.all(kSizeS),
            child: Column(children: [
              Container(
                  height: 500,
                  child: ListView(
                    children: [
                      SettingItem(
                        icon: Icons.label,
                        text: "Labels",
                        amount: 8,
                        routeName: LabelScreen.routeName,
                      ),
                      CustomDivider(),
                      SettingItem(
                        icon: Icons.category,
                        text: "Categories",
                        amount: 22,
                        routeName: CategoryScreen.routeName,
                      ),
                      CustomDivider(),
                      kSizedBoxVerticalXXS,
                      FutureBuilder<String>(
                          future: getVersionNumber(),
                          builder: (ctx, version) {
                            if (version.connectionState ==
                                ConnectionState.done) {
                              if (version.hasData)
                                return Text(
                                  "Setthi version ${version.data.toString()}",
                                  style: kBody1Black,
                                );
                            }
                            return kSizedBoxVerticalXXS;
                          })
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.all(kSizeS),
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
