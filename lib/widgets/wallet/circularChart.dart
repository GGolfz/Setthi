import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:setthi/config/color.dart';
import 'package:setthi/config/constants.dart';
import 'package:setthi/config/style.dart';
import 'package:setthi/provider/walletProvider.dart';
import 'package:setthi/widgets/wallet/indicator.dart';

class CircularChart extends StatefulWidget {
  final CategoryChartDataItemEach data;
  CircularChart(this.data);
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
            child: widget.data.data.length != 0
                ? Row(children: [
                    Expanded(
                      child: AspectRatio(
                          aspectRatio: 1,
                          child: PieChart(
                            graphData(),
                          )),
                    ),
                    Container(
                      height: double.infinity,
                      width: 100,
                      child: ListView.separated(
                        itemBuilder: (ctx, index) => Indicator(
                          color: widget.data.data[index].color,
                          text: widget.data.data[index].name,
                          textColor: kNeutralWhite,
                        ),
                        separatorBuilder: (ctx, index) => kSizedBoxVerticalXS,
                        itemCount: widget.data.data.length,
                      ),
                    )
                  ])
                : Column(children: [
                    SizedBox(
                        height: 120,
                        child: Image.asset(
                          "assets/images/empty-data.png",
                          fit: BoxFit.contain,
                        )),
                    Text(
                      "No data",
                      style: kBody1White,
                    )
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
    if (widget.data.data.length == 0) {
      return List.generate(1, (index) => PieChartSectionData(title: ''));
    }
    int index = -1;
    return widget.data.data.map((data) {
      index += 1;
      return PieChartSectionData(
          color: data.color,
          value: data.amount,
          radius: index == touchedIndex ? 50 : 40,
          title: data.label,
          titleStyle: TextStyle(
              fontSize: index == touchedIndex ? 14 : 10,
              fontWeight: FontWeight.bold,
              color: kNeutralWhite));
    }).toList();
  }
}
