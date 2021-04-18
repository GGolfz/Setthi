import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import '../config/color.dart';
import '../config/constants.dart';
import '../config/style.dart';
import '../model/httpException.dart';
import '../provider/authenicateProvider.dart';
import '../provider/categoryProvider.dart';
import '../provider/labelProvider.dart';
import '../screens/categoryScreen.dart';
import '../screens/labelScreen.dart';
import '../widgets/buttons/actionButton.dart';
import '../widgets/layout/appBar.dart';
import '../widgets/layout/divider.dart';
import '../widgets/layout/errorDialog.dart';
import '../widgets/setting/settingItem.dart';

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
    fetchData();
    super.initState();
  }

  void fetchData() async {
    try {
      await Provider.of<LabelProvider>(context, listen: false).fetchLabels();
      await Provider.of<CategoryProvider>(context, listen: false)
          .fetchCategories();
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
                  height: MediaQuery.of(context).size.height * 0.6,
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
