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
  var isStart = false;
  var renderText = false;
  var height = kSizeXL + 60;
  AnimationController animationController1;
  AnimationController animationController2;
  @override
  void initState() {
    super.initState();
    loadWidget();
    animationController1 =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animationController2 =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    animationController1.forward();
    animationController2.forward();
  }

  @override
  void dispose() {
    super.dispose();
    animationController1.dispose();
    animationController2.dispose();
  }

  void animatedUp() {
    setState(() {
      height = kSizeXL;
    });
  }

  void loadWidget() async {
    Timer(Duration(seconds: 1, milliseconds: 500), () {
      animatedUp();
    });
    Timer(Duration(seconds: 3, milliseconds: 250), () {
      setState(() {
        renderText = true;
      });
    });
    Timer(Duration(seconds: 5), () {
      setState(() {
        isStart = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final animation1 =
        Tween(begin: 0.0, end: 1.0).animate(animationController1);
    final animation2 =
        Tween(begin: 0.0, end: 1.0).animate(animationController2);
    return !isStart
        ? Container(
            padding: EdgeInsets.symmetric(vertical: kSizeS, horizontal: kSizeM),
            width: double.infinity,
            height: double.infinity,
            color: kGold100,
            child: Column(children: [
              AnimatedContainer(
                duration: Duration(seconds: 1, milliseconds: 500),
                height: height,
                child: Container(
                  color: Colors.transparent,
                  height: kSizeXL + 60,
                  width: double.infinity,
                ),
              ),
              FadeTransition(
                opacity: animation1,
                child: LogoImage(),
              ),
              renderText
                  ? FadeTransition(
                      opacity: animation2,
                      child: LogoText(),
                    )
                  : kSizedBoxXXS,
            ]),
          )
        : widget.nextScreen;
  }
}
