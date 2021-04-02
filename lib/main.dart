import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import './config/color.dart';
import './provider/authenicateProvider.dart';
import './provider/walletProvider.dart';
import './provider/savingProvider.dart';
import './screens/categoryScreen.dart';
import './screens/labelScreen.dart';
import './screens/splashScreen.dart';
import './screens/transactionScreen.dart';
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
        ChangeNotifierProvider(create: (ctx) => AuthenticateProvider()),
        ChangeNotifierProxyProvider(
          create: (ctx) => WalletProvider(null, []),
          update: (ctx, auth, prev) =>
              WalletProvider(auth.token, prev == null ? [] : prev.wallets),
        ),
        ChangeNotifierProxyProvider(
          create: (ctx) => SavingProvider(null, []),
          update: (ctx, auth, prev) =>
              SavingProvider(auth.token, prev == null ? [] : prev.wallets),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        theme: ThemeData(
            fontFamily: 'Quicksand',
            primaryColor: kGold200,
            colorScheme: ColorScheme.light().copyWith(primary: kGold500)),
        title: 'Setthi',
        home: Consumer<AuthenticateProvider>(
            builder: (ctx, auth, _) => SplashScreen(
                nextScreen: auth.isAuth
                    ? MainScreen()
                    : FutureBuilder(
                        future: Future<bool>.sync(() async {
                          try {
                            await auth.tryAutoLogin();
                            return true;
                          } catch (error) {
                            return false;
                          }
                        }),
                        builder: (ctx, authResultSnapshot) =>
                            LandingScreen()))),
        routes: {
          CategoryScreen.routeName: (ctx) => CategoryScreen(),
          LabelScreen.routeName: (ctx) => LabelScreen(),
          TransactionScreen.routeName: (ctx) => TransactionScreen(),
        },
      ),
    );
  }
}
