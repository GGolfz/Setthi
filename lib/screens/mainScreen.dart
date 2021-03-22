import 'package:flutter/material.dart';
import 'package:setthi/widgets/buttons/addButton.dart';
import './budgetScreen.dart';
import './moreScreen.dart';
import './timelineScreen.dart';
import './walletScreen.dart';
import '../widgets/layout/bottomBar.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static const routeName = '/';
  String _currentTab = TimelineScreen.routeName;
  final screen = {
    TimelineScreen.routeName: TimelineScreen(),
    BudgetScreen.routeName: BudgetScreen(),
    WalletScreen.routeName: WalletScreen(),
    MoreScreen.routeName: MoreScreen(),
  };

  void _changeTab(String tab) {
    setState(() {
      _currentTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: screen[_currentTab],
        ),
        floatingActionButton: AddButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomBar(
          currentTab: _currentTab,
          changeTab: _changeTab,
        ));
  }
}
