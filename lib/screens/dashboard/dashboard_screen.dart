import 'package:admin/controllers/auth_controller.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/my_fields.dart';
import 'package:admin/screens/dashboard/components/realtime_fl_ch.dart';
import 'package:admin/screens/dashboard/components/resume_card.dart';
import 'package:admin/screens/dashboard/components/temps_reel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../../widgets/header.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  AuthController _authController = Get.put(AuthController());

  String? station;

  @override
  Widget build(BuildContext context) {
    return Obx(() => SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                Header(),
                SizedBox(height: defaultPadding),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Données en temps réel",
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                              if (!Responsive.isMobile(context))
                                _buildSelectStationWidget(),
                            ],
                          ),
                          if (Responsive.isMobile(context))
                            _buildSelectStationWidget(),
                          SizedBox(height: defaultPadding),
                          _authController.currentAccount!.stations!.length > 0
                              ? RealTimeLineChart()
                              : Container(
                                  height: 300,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(18)),
                                      color: secondaryColor),
                                  child: Center(
                                      child: Text(
                                    'Aucune donnée disponible pour le moment',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                  )),
                                ),
                          SizedBox(height: defaultPadding),
                          // TempsReel(),
                          // if (Responsive.isMobile(context))
                          //   SizedBox(height: defaultPadding),
                          // if (Responsive.isMobile(context)) StarageDetails(),
                        ],
                      ),
                    ),
                    if (!Responsive.isMobile(context))
                      SizedBox(width: defaultPadding),
                    // On Mobile means if the screen is less than 850 we dont want to show it
                    // if (!Responsive.isMobile(context))
                    //   Expanded(
                    //     flex: 2,
                    //     // child: StarageDetails(),
                    //     child: Container(
                    //       decoration: BoxDecoration(
                    //         color: secondaryColor,
                    //         borderRadius:
                    //             const BorderRadius.all(Radius.circular(10)),
                    //       ),
                    //     ),
                    //   ),
                  ],
                )
              ],
            ),
          ),
        ));
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
            iconSize: 36,
            icon: const Icon(Icons.arrow_drop_down),
            borderRadius: BorderRadius.circular(10),
            hint: Text('Choisir une station',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
            items: _authController.currentAccount!.stations!
                .map(_buildMenuItem)
                .toList(),
            onChanged: (value) => setState(() {
                  this.station = value as String?;
                })),
      ),
    );
  }

  DropdownMenuItem<String> _buildMenuItem(Map<String, dynamic> item) {
    return DropdownMenuItem<String>(
        value: item['code'],
        child: Text(item['designation'],
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)));
  }
}
