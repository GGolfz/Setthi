import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/widgets/wallet/indicator.dart';

class CircularChart extends StatefulWidget {
  @override
  _CircularChartState createState() => _CircularChartState();
}

class _CircularChartState extends State<CircularChart> {
  int touchedIndex;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.8,
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: kBorderRadiusS, color: kNeutral700),
        child: Padding(
            padding:
                const EdgeInsets.only(right: 18, left: 12, top: 24, bottom: 12),
            child: Row(children: [
              Expanded(
                child: AspectRatio(
                    aspectRatio: 1,
                    child: PieChart(
                      graphData(),
                    )),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Indicator(
                    color: Color(0xff0293ee),
                    text: 'First',
                    textColor: kNeutral100,
                  ),
                  kSizedBoxVerticalXS,
                  Indicator(
                    color: Color(0xfff8b250),
                    text: 'Second',
                    textColor: kNeutral100,
                  ),
                  kSizedBoxVerticalXS,
                  Indicator(
                    color: Color(0xff845bef),
                    text: 'Third',
                    textColor: kNeutral100,
                  ),
                  kSizedBoxVerticalXS,
                  Indicator(
                    color: Color(0xff13d38e),
                    text: 'Fourth',
                    textColor: kNeutral100,
                  ),
                ],
              ),
            ])),
      ),
    );
  }

  PieChartData graphData() {
    return PieChartData(
        pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
          setState(() {
            final desiredTouch =
                pieTouchResponse.touchInput is! PointerExitEvent &&
                    pieTouchResponse.touchInput is! PointerUpEvent;
            if (desiredTouch && pieTouchResponse.touchedSection != null) {
              touchedIndex =
                  pieTouchResponse.touchedSection.touchedSectionIndex;
            } else {
              touchedIndex = -1;
            }
          });
        }),
        borderData: FlBorderData(
          show: false,
        ),
        sectionsSpace: 0,
        centerSpaceRadius: 40,
        sections: showingSections());
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 16 : 14;
      final double radius = isTouched ? 50 : 40;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
}
