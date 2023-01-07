import 'dart:math';

import 'package:inte_eco_admin/controllers/realtime_controller.dart';
import 'package:inte_eco_admin/models/data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../responsive.dart';
import 'file_info_card.dart';

class ResumeCard extends StatelessWidget {
  RealTimeController controller = Get.put(RealTimeController());

  DataModel data;

  ResumeCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 80,
      child: GridView(
        shrinkWrap: true,
        primary: false,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (!Responsive.isMobile(context)) ? 5 : 2,
          mainAxisSpacing: defaultPadding,
          crossAxisSpacing: defaultPadding,
          childAspectRatio: (!Responsive.isMobile(context)) ? 1.75 : 1.2,
        ),
        children: [
          _buildCardInfo(
              context, "CO2", data.co2.toString(), Color(0xFFEE2727)),
          _buildCardInfo(
              context,
              "H2s",
              ((Random().nextDouble() * 1.9).toPrecision(3)).toString(),
              Color(0xff4af699)),
          _buildCardInfo(context, "CO", data.co.toString(), Color(0xFFFFCF26)),
          _buildCardInfo(
              context,
              "Température",
              data.temperature.toString() + " °C",
              Color.fromARGB(255, 204, 0, 255)),
          _buildCardInfo(
              context,
              "Humidité",
              data.tauxHumidite.toString() + "%",
              Color.fromARGB(255, 255, 136, 0)),
        ],
      ),
    );
  }

  Container _buildCardInfo(
      BuildContext context, String element, String value, Color color) {
    return Container(
        padding: EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Container(
          padding: EdgeInsets.all(defaultPadding / 2),
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(element,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w500)),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(value,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ));
  }
}
