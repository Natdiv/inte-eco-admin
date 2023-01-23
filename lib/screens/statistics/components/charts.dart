import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../controllers/auth_controller.dart';

class ChartStats extends StatefulWidget {
  ChartStats({super.key});

  @override
  State<ChartStats> createState() => _ChartStatsState();
}

class _ChartStatsState extends State<ChartStats> {
  AuthController _authController = Get.put(AuthController());

  String? station;

  List<Map<String, dynamic>> periodes = [
    {'label': 'Aujourd\'hui', 'value': 'today'},
    {'label': 'Cette semaine', 'value': 'week'},
    {'label': 'Ce mois', 'value': 'month'},
    {'label': '3 mois', 'value': 'trimester'},
    {'label': '6 mois', 'value': 'semester'},
    {'label': 'Cette année', 'value': 'year'},
  ];

  String? periode;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_buildChartSelector()],
    );
  }

  Widget _buildChartSelector() {
    return Row(
      children: [
        _buildSelectStationWidget(),
        SizedBox(
          width: 8,
        ),
        _buildSelectPeriodWidget()
      ],
    );
  }

  Container _buildSelectStationWidget() {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: secondaryColor, borderRadius: BorderRadius.circular(10)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
            value: station,
            iconSize: 30,
            icon: const Icon(Icons.arrow_drop_down),
            borderRadius: BorderRadius.circular(10),
            hint: const Text('Choisir une station',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w400)),
            items: _authController.currentAccount!.stations!
                .map(_buildMenuItemStation)
                .toList(),
            onChanged: (value) => setState(() {
                  this.station = value as String?;
                })),
      ),
    );
  }

  DropdownMenuItem<String> _buildMenuItemStation(Map<String, dynamic> item) {
    return DropdownMenuItem<String>(
        value: item['code'],
        child: Text(item['designation'],
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400)));
  }

  DropdownMenuItem<String> _buildMenuItemPeriod(Map<String, dynamic> item) {
    return DropdownMenuItem<String>(
        value: item['value'],
        child: Text(item['label'],
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400)));
  }

  Container _buildSelectPeriodWidget() {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: secondaryColor, borderRadius: BorderRadius.circular(10)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
            value: periode,
            iconSize: 30,
            icon: const Icon(Icons.arrow_drop_down),
            borderRadius: BorderRadius.circular(10),
            hint: const Text('Choisir une période',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w400)),
            items: periodes.map(_buildMenuItemPeriod).toList(),
            onChanged: (value) => setState(() {
                  this.periode = value as String;
                })),
      ),
    );
  }
}
