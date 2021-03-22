import 'package:flutter/material.dart';
import './components/wallet.dart';
import 'components/TimeLine.dart';
import 'components/more.dart';
import 'components/budget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

const iconColor = Color(0xFFD3AE36);

class _HomeState extends State<Home> {
  int currentTab = 0;
  final List<Widget> screen = [
    TimeLine(),
    Budget(),
    More(),
    Wallet(),
  ];
  Widget _builderIcon(Widget page, Icon icon, int currentab) {
    return Row(
      children: [
        MaterialButton(
          minWidth: 50,
          onPressed: () {
            setState(() {
              currentScreen = page;
              currentTab = currentab;
            });
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [icon],
          ),
        ),
      ],
    );
  }

  Widget currentScreen = TimeLine();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Color(0xFFF4DF99),
        ),
        backgroundColor: Color(0xFF555555),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomAppBar(
          notchMargin: 8.0,
          color: Color(0xFF555555),
          shape: CircularNotchedRectangle(),
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _builderIcon(
                    TimeLine(),
                    Icon(
                      Icons.timer,
                      color: currentTab == 0 ? iconColor : Colors.white,
                    ),
                    0),
                _builderIcon(
                    Wallet(),
                    Icon(
                      Icons.wallet_travel,
                      color: currentTab == 1 ? iconColor : Colors.white,
                    ),
                    1),
                _builderIcon(
                    Budget(),
                    Icon(
                      Icons.attach_money,
                      color: currentTab == 2 ? iconColor : Colors.white,
                    ),
                    2),
                _builderIcon(
                    More(),
                    Icon(Icons.more,
                        color: currentTab == 3 ? iconColor : Colors.white),
                    3)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
