import 'package:inte_eco_admin/controllers/main_controller.dart';
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
        minX: 1,
        maxX: 13,
        maxY: 1000,
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

  List<LineChartBarData> get lineBarsData1 => [lineChartBarDataH2s];

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
      case 100:
        text = '100';
        break;
      case 500:
        text = '500';
        break;
      case 1000:
        text = '1000';
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
    switch (value.toInt()) {
      case 1:
        text = RotatedBox(
          quarterTurns: 3,
          child: Text('Janvier', style: style),
        );
        break;
      case 2:
        text = RotatedBox(
          quarterTurns: 3,
          child: Text('Février', style: style),
        );
        break;
      case 3:
        text = RotatedBox(
          quarterTurns: 3,
          child: Text('Mars', style: style),
        );
        break;
      case 4:
        text = RotatedBox(
          quarterTurns: 3,
          child: Text('Avril', style: style),
        );
        break;
      case 5:
        text = RotatedBox(
          quarterTurns: 3,
          child: Text('Mai', style: style),
        );
        break;
      case 6:
        text = RotatedBox(
          quarterTurns: 3,
          child: Text('Juin', style: style),
        );
        break;
      case 7:
        text = RotatedBox(
          quarterTurns: 3,
          child: Text('Juillet', style: style),
        );
        break;
      case 8:
        text = RotatedBox(
          quarterTurns: 3,
          child: Text('Août', style: style),
        );
        break;
      case 9:
        text = RotatedBox(
          quarterTurns: 3,
          child: Text('Septembre', style: style),
        );
        break;
      case 10:
        text = RotatedBox(
          quarterTurns: 3,
          child: Text('Octobre', style: style),
        );
        break;
      case 11:
        text = RotatedBox(
          quarterTurns: 3,
          child: Text('Novembre', style: style),
        );
        break;
      case 12:
        text = RotatedBox(
          quarterTurns: 3,
          child: Text('Décembre', style: style),
        );
        break;

      default:
        text = const Text('');
        break;
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
          var moisp = (dataStation.indexOf(e) > 0)
              ? dataStation[dataStation.indexOf(e) - 1]
                  .date!
                  .toDate()
                  .toString()
                  .split(' ')[0]
                  .split('-')[1]
              : '0';
          var jourp = (dataStation.indexOf(e) > 0)
              ? dataStation[dataStation.indexOf(e) - 1]
                  .date!
                  .toDate()
                  .toString()
                  .split(' ')[0]
                  .split('-')[2]
              : '0';
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
          var heurep = (dataStation.indexOf(e) > 0)
              ? dataStation[dataStation.indexOf(e) - 1]
                  .date!
                  .toDate()
                  .toString()
                  .split(' ')[1]
                  .split('.')[0]
                  .split(':')[0]
              : '0';
          var minutep = (dataStation.indexOf(e) > 0)
              ? dataStation[dataStation.indexOf(e) - 1]
                  .date!
                  .toDate()
                  .toString()
                  .split(' ')[1]
                  .split('.')[0]
                  .split(':')[1]
              : '0';
          var secondp = (dataStation.indexOf(e) > 0)
              ? dataStation[dataStation.indexOf(e) - 1]
                  .date!
                  .toDate()
                  .toString()
                  .split(' ')[1]
                  .split('.')[0]
                  .split(':')[2]
              : '0';
          double x = double.parse(mois) +
              double.parse(jour) / 31 +
              double.parse(heure) / 24 / 31 +
              double.parse(minute) / 60 / 24 / 31 +
              double.parse(second) / 60 / 60 / 24 / 31;
          double xp = double.parse(moisp) +
              double.parse(jourp) / 31 +
              double.parse(heurep) / 24 / 31 +
              double.parse(minutep) / 60 / 24 / 31 +
              double.parse(secondp) / 60 / 60 / 24 / 31;
          print(
              "$mois $jour $heure $minute $second => $x > ${xp.toInt()} ${x > xp}");

          if (int.parse(jour) == 1) {
            x = double.parse(jour);
            print("POUR LE PREMIER JOUR: $x du $mois");
          }

          return FlSpot(x, double.parse(e.h2s!));
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
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff2c274c),
                      Color(0xff46426c),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      right: 16,
                      top: 16,
                      child: Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                color: Color(0xff4af699),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
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
                                dataStation:
                                    controller.monthlyData.reversed.toList()),
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
              gradient: LinearGradient(
                colors: [
                  Color(0xff2c274c),
                  Color(0xff46426c),
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Center(
              child: SizedBox(
                height: 60,
                width: 60,
                child: CircularProgressIndicator(),
              ),
            )));
  }
}
