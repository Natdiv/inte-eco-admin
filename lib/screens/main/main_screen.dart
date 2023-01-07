import 'package:admin/controllers/auth_controller.dart';
import 'package:admin/controllers/main_controller.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:admin/screens/splash.dart';
import 'package:admin/screens/statistics/statistics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../compte/compte.dart';
import '../gestion_clients/clients.dart';
import '../gestion_stations/stations.dart';
import '../stations/station.dart';
import 'components/side_menu.dart';

class MainScreen extends StatelessWidget {
  MainController controller = Get.put(MainController());
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (authController.currentAccount!.role != null)
          ? Scaffold(
              key: controller.scaffoldKey,
              drawer: SideMenu(),
              body: SafeArea(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // We want this side menu only for large screen
                  if (Responsive.isDesktop(context))
                    Expanded(
                      // default flex = 1
                      // and it takes 1/6 part of the screen
                      child: SideMenu(),
                    ),
                  Expanded(
                    // It takes 5/6 part of the screen
                    flex: 5,
                    child: _buildScreen(),
                  ),
                ],
              )),
            )
          : SplashScreen(),
    );
  }

  Widget _buildScreen() {
    switch (controller.screenIndex) {
      case 0:
        return DashboardScreen();
      case 1:
        return StatiticsScreen();
      case 2:
        return StationScreen();
      case 3:
        return MonCompteScreen();
      case 4:
        return GestionClientScreen();
      case 5:
        return GestionStationScreen();
      default:
        return DashboardScreen();
    }
  }
}
