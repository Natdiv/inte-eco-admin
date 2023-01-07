import 'package:admin/controllers/auth_controller.dart';
import 'package:admin/controllers/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  SideMenu({
    Key? key,
  }) : super(key: key);

  MainController controller = Get.put(MainController());
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Center(
                  child: Image.asset(
                    "assets/logo/logo.png",
                    width: 100,
                    scale: 1,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                margin: EdgeInsets.only(bottom: 0),
              ),
              Container(
                color: (controller.screenIndex == 0)
                    ? Color(0xFF212332)
                    : Colors.transparent,
                child: DrawerListTile(
                  title: "Dashboard",
                  svgSrc: "assets/icons/menu_dashbord.svg",
                  press: () {
                    controller.screenIndex = 0;
                  },
                ),
              ),
              Container(
                color: (controller.screenIndex == 1)
                    ? Color(0xFF212332)
                    : Colors.transparent,
                child: DrawerListTile(
                  title: "Statistiques",
                  svgSrc: "assets/icons/monitoring.svg",
                  press: () {
                    controller.screenIndex = 1;
                  },
                ),
              ),
              if (authController.currentAccount!.role != "admin")
                Container(
                  color: (controller.screenIndex == 2)
                      ? Color(0xFF212332)
                      : Colors.transparent,
                  child: DrawerListTile(
                    title: "Stations",
                    svgSrc: "assets/icons/sensors.svg",
                    press: () {
                      controller.screenIndex = 2;
                    },
                  ),
                ),
              Container(
                color: (controller.screenIndex == 3)
                    ? Color(0xFF212332)
                    : Colors.transparent,
                child: DrawerListTile(
                  title: "Mon compte",
                  svgSrc: "assets/icons/person.svg",
                  press: () {
                    controller.screenIndex = 3;
                  },
                ),
              ),
              if (authController.currentAccount!.role == "admin")
                Container(
                    color: (controller.screenIndex == 4)
                        ? Color(0xFF212332)
                        : Colors.transparent,
                    child: DrawerListTile(
                      title: "Gestion de compte",
                      svgSrc: "assets/icons/manage_accounts.svg",
                      press: () {
                        controller.screenIndex = 4;
                      },
                    )),
              if (authController.currentAccount!.role == "admin")
                Container(
                    color: (controller.screenIndex == 5)
                        ? Color(0xFF212332)
                        : Colors.transparent,
                    child: DrawerListTile(
                      title: "Gestion de stations",
                      svgSrc: "assets/icons/settings_input_antenna.svg",
                      press: () {
                        controller.screenIndex = 5;
                      },
                    )),
            ],
          ),
        ));
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
