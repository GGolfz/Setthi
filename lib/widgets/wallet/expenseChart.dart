import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/color.dart';
import '../../config/constants.dart';
import '../../config/style.dart';
import '../../provider/walletProvider.dart';

class ExpenseChart extends StatefulWidget {
  @override
  _ExpenseChartState createState() => _ExpenseChartState();
}

class _ExpenseChartState extends State<ExpenseChart> {
  List<Color> gradientColors = [
    const Color(0xFFDEC489),
    const Color(0xFFF6E0A4),
    const Color(0xFFD1B372),
    const Color(0xFFE3CC97),
    const Color(0xFFBF9A5E),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 2,
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: kBorderRadiusS, color: kNeutral700),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 18, left: 12, top: 24, bottom: 12),
              child: Consumer<WalletProvider>(
                  builder: (ctx, wallet, _) => LineChart(
                        graphData(wallet.chartData),
                      )),
            ),
          ),
        ),
      ],
    );
  }

  double getInterval(double max) {
    return max == 0 ? 1 : max / 5;
  }

  LineChartData graphData(ChartData data) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: getInterval(data.max) / 2,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: kNeutral500,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: kNeutral500,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => kBody1Black,
          getTitles: (value) {
            return data.data[value.toInt()].date;
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => kBody1Black,
          getTitles: (value) {
            return (value.floor()).toString();
          },
          interval: getInterval(data.max),
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true, border: Border.all(color: kNeutral500, width: 1)),
      minX: 0,
      maxX: 6,
      minY: 0,
      maxY: data.max,
      lineBarsData: [
        LineChartBarData(
          spots: Iterable<int>.generate(7)
              .toList()
              .map((i) => FlSpot(i.toDouble(), data.data[i].amount))
              .toList(),
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}
