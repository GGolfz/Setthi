import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/color.dart';
import '../../config/constants.dart';
import '../../config/style.dart';
import '../../provider/walletProvider.dart';

class BalanceChart extends StatefulWidget {
  @override
  _BalanceChartState createState() => _BalanceChartState();
}

class _BalanceChartState extends State<BalanceChart> {
  List<Color> incomeGradientColors = [
    const Color(0xFF2EB62C),
    const Color(0xFF57C84D),
    const Color(0xFF83D475),
  ];
  List<Color> expenseGradientColor = [
    const Color(0xFFCC1C13),
    const Color(0xFFEA4C46),
    const Color(0xFFF07470),
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: kBorderRadiusS, color: kNeutral700),
        child: Padding(
          padding:
              const EdgeInsets.only(right: 18, left: 12, top: 24, bottom: 12),
          child: Consumer<WalletProvider>(
              builder: (ctx, wallet, _) => LineChart(
                    graphData(wallet.chartData),
                  )),
        ),
      ),
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
            return data.income[value.toInt()].date;
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
          reservedSize: 32,
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
              .map((i) => FlSpot(i.toDouble(), data.income[i].amount))
              .toList(),
          colors: incomeGradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
        ),
        LineChartBarData(
          spots: Iterable<int>.generate(7)
              .toList()
              .map((i) => FlSpot(i.toDouble(), data.expense[i].amount))
              .toList(),
          colors: expenseGradientColor,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
        ),
      ],
    );
  }
}
