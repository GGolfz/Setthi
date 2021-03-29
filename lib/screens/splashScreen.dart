import 'dart:async';

import 'package:flutter/material.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/widgets/logo/logoImage.dart';
import 'package:setthi/widgets/logo/logoText.dart';

class SplashScreen extends StatefulWidget {
  final Widget nextScreen;
  SplashScreen({@required this.nextScreen});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  var _isLaunch = false;
  var _renderText = false;
  var _height = kSizeXL + kSizeL;
  AnimationController _animationController1;
  AnimationController _animationController2;
  @override
  void initState() {
    super.initState();
    loadWidget();
    _animationController1 =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationController2 =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _animationController1.forward();
    _animationController2.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController1.dispose();
    _animationController2.dispose();
  }

  void animatedUp() {
    Timer(Duration(seconds: 1, milliseconds: 500), () {
      setState(() {
        _height = kSizeXL;
      });
    });
  }

  void showText() {
    Timer(Duration(seconds: 3, milliseconds: 250), () {
      setState(() {
        _renderText = true;
      });
    });
  }

  void launchScreen() {
    Timer(Duration(seconds: 5), () {
      setState(() {
        _isLaunch = true;
      });
    });
  }

  void loadWidget() async {
    animatedUp();
    showText();
    launchScreen();
  }

  Animation<double> tweenAnimation(controller) {
    return Tween(begin: 0.0, end: 1.0).animate(controller);
  }

  Widget fadeWidget(animation, widget) {
    return FadeTransition(
      opacity: animation,
      child: widget,
    );
  }

  Widget splashWidget(animation1, animation2) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: kSizeS, horizontal: kSizeM),
      width: double.infinity,
      height: double.infinity,
      color: kGold100,
      child: Column(children: [
        AnimatedContainer(
          duration: Duration(seconds: 1, milliseconds: 500),
          height: _height,
          child: Container(
            color: Colors.transparent,
            height: kSizeXL + kSizeL,
            width: double.infinity,
          ),
        ),
        fadeWidget(animation1, LogoImage()),
        _renderText ? fadeWidget(animation1, LogoText()) : kSizedBoxXXS,
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final animation1 = tweenAnimation(_animationController1);
    final animation2 = tweenAnimation(_animationController2);
    return _isLaunch ? widget.nextScreen : splashWidget(animation1, animation2);
  }
}
