import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/config/style.dart';
import 'package:setthi/model/httpException.dart';
import 'package:setthi/provider/authenicateProvider.dart';
import 'package:setthi/provider/categoryProvider.dart';
import 'package:setthi/provider/labelProvider.dart';
import 'package:setthi/screens/categoryScreen.dart';
import 'package:setthi/screens/labelScreen.dart';
import 'package:setthi/widgets/buttons/actionButton.dart';
import 'package:setthi/widgets/layout/appBar.dart';
import 'package:setthi/widgets/layout/divider.dart';
import 'package:setthi/widgets/setting/settingItem.dart';
import '../widgets/layout/errorDialog.dart';

class SettingScreen extends StatefulWidget {
  static final routeName = '/setting';

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Future<String> getVersionNumber() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final version = packageInfo.version;
    final buildNumber = packageInfo.buildNumber;
    return '$version ($buildNumber)';
  }

  @override
  void initState() {
    // Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
    // Provider.of<LabelProvider>(context, listen: false).fetchLabels();
    fetchData();
    super.initState();
  }

  void fetchData() async {
    try {
      await Provider.of<LabelProvider>(context, listen: false).fetchLabels();
      await Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
    } on HttpException catch (error) {
      showErrorDialog(
          context: context,
          text: error.message,
          isNetwork: error.isInternetProblem);
    }
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
                      Consumer<LabelProvider>(
                          builder: (ctx, label, _) => SettingItem(
                                icon: Icons.label,
                                text: "Labels",
                                amount: label.labelCount,
                                routeName: LabelScreen.routeName,
                              )),
                      CustomDivider(),
                      Consumer<CategoryProvider>(
                          builder: (ctx, category, _) => SettingItem(
                                icon: Icons.category,
                                text: "Categories",
                                amount: category.categoryCount,
                                routeName: CategoryScreen.routeName,
                              )),
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
                    text: "Sign Out",
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
