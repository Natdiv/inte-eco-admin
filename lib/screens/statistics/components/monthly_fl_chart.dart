import 'package:inte_eco_admin/constants.dart';
import 'package:inte_eco_admin/controllers/statistics_controller.dart';
import 'package:inte_eco_admin/models/data_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class _MonthlyLineChart extends StatelessWidget {
  _MonthlyLineChart({required this.dataStation});
  final List<DataModel> dataStation;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampleData1,
      swapAnimationCurve: Curves.easeInOut,
      swapAnimationDuration: const Duration(milliseconds: 500),
    );
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0.5,
        maxX: 12.5,
        maxY: 4001,
        minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData1 =>
      [lineChartBarDataH2s, lineChartBarDataCo2];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff75729e),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 500:
        text = '500';
        break;
      case 1000:
        text = '1000';
        break;
      case 2000:
        text = '2000';
        break;
      case 4000:
        text = '4000';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff72719b),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;

    if (value == 1.0) {
      text = const RotatedBox(
        quarterTurns: 3,
        child: Text('Janvier', style: style),
      );
    } else if (value == 2.0) {
      text = const RotatedBox(
        quarterTurns: 3,
        child: Text('Février', style: style),
      );
    } else if (value == 3.0) {
      text = const RotatedBox(
        quarterTurns: 3,
        child: Text('Mars', style: style),
      );
    } else if (value == 4.0) {
      text = const RotatedBox(
        quarterTurns: 3,
        child: Text('Avril', style: style),
      );
    } else if (value == 5.0) {
      text = const RotatedBox(
        quarterTurns: 3,
        child: Text('Mai', style: style),
      );
    } else if (value == 6.0) {
      text = const RotatedBox(
        quarterTurns: 3,
        child: Text('Juin', style: style),
      );
    } else if (value == 7.0) {
      text = const RotatedBox(
        quarterTurns: 3,
        child: Text('Juillet', style: style),
      );
    } else if (value == 8.0) {
      text = const RotatedBox(
        quarterTurns: 3,
        child: Text('Août', style: style),
      );
    } else if (value == 9.0) {
      text = const RotatedBox(
        quarterTurns: 3,
        child: Text('Septembre', style: style),
      );
    } else if (value == 10.0) {
      text = const RotatedBox(
        quarterTurns: 3,
        child: Text('Octobre', style: style),
      );
    } else if (value == 11.0) {
      text = const RotatedBox(
        quarterTurns: 3,
        child: Text('Novembre', style: style),
      );
    } else if (value == 12.0) {
      text = const RotatedBox(
        quarterTurns: 3,
        child: Text('Décembre', style: style),
      );
    } else {
      text = Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 90,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Color(0xff4e4965), width: 4),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarDataH2s => LineChartBarData(
        isCurved: true,
        color: const Color(0xff4af699),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: false,
          color: const Color(0x00aa4cfc),
        ),
        spots: dataStation.reversed.map((e) {
          // print(e.date!.toDate().toString().split(' ')[1].split('.')[0]);
          var mois = e.date!.toDate().toString().split(' ')[0].split('-')[1];
          var jour = e.date!.toDate().toString().split(' ')[0].split('-')[2];

          var heure = e.date!
              .toDate()
              .toString()
              .split(' ')[1]
              .split('.')[0]
              .split(':')[0];
          var minute = e.date!
              .toDate()
              .toString()
              .split(' ')[1]
              .split('.')[0]
              .split(':')[1];
          var second = e.date!
              .toDate()
              .toString()
              .split(' ')[1]
              .split('.')[0]
              .split(':')[2];

          double x = double.parse(mois) + double.parse(jour) / 32;
          print(
              "$mois $jour $heure $minute $second => $x : ${double.parse(e.h2s!)}");

          if (jour == 1.0) {
            x = double.parse(jour);
            print("POUR LE PREMIER JOUR: $x du $mois");
          }

          return FlSpot(x, double.parse(e.h2s!));
        }).toList(),
      );
  LineChartBarData get lineChartBarDataCo2 => LineChartBarData(
        isCurved: true,
        color: const Color(0xFFEE2727),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: false,
          color: const Color(0x00aa4cfc),
        ),
        spots: dataStation.reversed.map((e) {
          var mois = e.date!.toDate().toString().split(' ')[0].split('-')[1];
          var jour = e.date!.toDate().toString().split(' ')[0].split('-')[2];
          double x = double.parse(mois) + double.parse(jour) / 32;
          return FlSpot(x, double.parse(e.co2!));
        }).toList(),
      );
}

class MonthlyLineChart extends StatelessWidget {
  StatsController controller = Get.put(StatsController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => (controller.monthlyData.length > 0)
        ? Container(
            height: 350,
            child: DecoratedBox(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                    color: secondaryColor),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      right: 16,
                      top: 16,
                      child: Row(
                        children: [
                          Container(
                              decoration: const BoxDecoration(
                                color: Color(0xff4af699),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                child: Text(
                                  'H 2 S',
                                  style: TextStyle(
                                      color: Color(0xff2c274c),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                          Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFEE2727),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                child: Text(
                                  'C O 2',
                                  style: TextStyle(
                                      color: Color(0xff2c274c),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                          Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFFFCF26),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                child: Text(
                                  'C O',
                                  style: TextStyle(
                                      color: Color(0xff2c274c),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              ))
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          'STATION XYZ',
                          style: const TextStyle(
                            color: Color(0xff827daa),
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Text(
                          'INTE ECO',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16, left: 6),
                            child: _MonthlyLineChart(
                                dataStation: controller.monthlyData),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.refresh,
                        color: Colors.white.withOpacity(1.0),
                      ),
                      onPressed: () {},
                    )
                  ],
                )),
          )
        : Container(
            height: 300,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(18)),
                color: secondaryColor),
            child: const Center(
              child: SizedBox(
                height: 60,
                width: 60,
                child: CircularProgressIndicator(),
              ),
            )));
  }
}
