import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../config/color.dart';
import '../provider/authenicateProvider.dart';
import '../screens/categoryScreen.dart';
import '../screens/labelScreen.dart';
import '../screens/transactionScreen.dart';
import './screens/landingScreen.dart';
import './screens/mainScreen.dart';

void main() {
  runApp(SetthiApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class SetthiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigatorKey = GlobalKey<NavigatorState>();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => AuthenticateProvider())
      ],
      child: Consumer<AuthenticateProvider>(
        builder: (ctx, auth, _) => MaterialApp(
          navigatorKey: navigatorKey,
          theme: ThemeData(
              primaryColor: kGold200,
              colorScheme: ColorScheme.light().copyWith(primary: kGold500)),
          title: 'Setthi',
          home: !auth.isAuth ? MainScreen() : LandingScreen(),
          routes: {
            CategoryScreen.routeName: (ctx) => CategoryScreen(),
            LabelScreen.routeName: (ctx) => LabelScreen(),
            TransactionScreen.routeName: (ctx) => TransactionScreen(),
          },
        ),
      ),
    );
  }
}
