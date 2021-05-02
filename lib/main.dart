import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:setthi/provider/categoryProvider.dart';
import 'package:setthi/provider/labelProvider.dart';
import 'package:setthi/provider/transactionProvider.dart';
import 'package:setthi/screens/settingScreen.dart';
import 'package:setthi/screens/tutorialScreen.dart';
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
        ChangeNotifierProxyProvider<AuthenticateProvider, WalletProvider>(
            create: (ctx) => WalletProvider(
                null, [], ChartData.empty, CategoryChartData.empty),
            update: (ctx, auth, prev) => WalletProvider(
                auth.token,
                prev == null ? [] : prev.wallets,
                prev == null ? ChartData.empty : prev.chartData,
                prev == null ? CategoryChartData.empty : prev.categoryData)),
        ChangeNotifierProxyProvider<AuthenticateProvider, SavingProvider>(
          create: (ctx) => SavingProvider(null, SavingGroup.empty),
          update: (ctx, auth, prev) =>
              SavingProvider(auth.token, prev == null ? [] : prev.saving),
        ),
        ChangeNotifierProxyProvider<AuthenticateProvider, CategoryProvider>(
            create: (ctx) => CategoryProvider(null, []),
            update: (ctx, auth, prev) => CategoryProvider(
                auth.token, prev == null ? [] : prev.categories)),
        ChangeNotifierProxyProvider<AuthenticateProvider, LabelProvider>(
            create: (ctx) => LabelProvider(null, []),
            update: (ctx, auth, prev) =>
                LabelProvider(auth.token, prev == null ? [] : prev.labels)),
        ChangeNotifierProxyProvider<AuthenticateProvider, TransactionProvider>(
            create: (ctx) => TransactionProvider(null, [], []),
            update: (ctx, auth, prev) => TransactionProvider(
                auth.token,
                prev == null ? [] : prev.transactions,
                prev == null ? [] : prev.allTransactions))
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
          SettingScreen.routeName: (ctx) => SettingScreen(),
          TutorialScreen.routeName: (ctx) => TutorialScreen()
        },
      ),
    );
  }
}
