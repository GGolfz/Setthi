import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:setthi/provider/authenicateProvider.dart';
import 'package:setthi/screens/categoryScreen.dart';
import 'package:setthi/screens/labelScreen.dart';
import 'package:setthi/widgets/layout/appBar.dart';

class SettingScreen extends StatelessWidget {
  static final routeName = '/setting';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SetthiAppBar(
          title: 'Setting',
        ),
        body: ListView(
          children: [
            ListTile(
              title: Text("Label"),
              onTap: () {
                Navigator.of(context).pushNamed(LabelScreen.routeName);
              },
            ),
            ListTile(
              title: Text("Category"),
              onTap: () {
                Navigator.of(context).pushNamed(CategoryScreen.routeName);
              },
            ),
            ListTile(
              title: Text("Logout"),
              onTap: () {
                Provider.of<AuthenticateProvider>(context, listen: false)
                    .logout();
              },
            )
          ],
        ));
  }
}
