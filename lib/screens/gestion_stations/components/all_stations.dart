import 'package:admin/models/user_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../controllers/station_controller.dart';

class AllStations extends StatefulWidget {
  AllStations({Key? key}) : super(key: key);

  @override
  State<AllStations> createState() => _AllStationsState();
}

class _AllStationsState extends State<AllStations> {
  StationController _stationController = Get.put(StationController());

  final _formKey = GlobalKey<FormState>();

  String? client;

  @override
  void initState() {
    super.initState();
    _stationController.getClientsList();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => DecoratedBox(
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
        child: (_stationController.entreprises.length > 0)
            ? Form(
                key: _formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 32),
                    child: (_stationController.isLoading)
                        ? Column(children: [
                            Text(
                              "Liste de stations",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ])
                        : Center(
                            child: Container(
                                height: 60,
                                width: 60,
                                child: CircularProgressIndicator()),
                          )),
              )
            : Center(
                child: Container(
                    height: 60, width: 60, child: CircularProgressIndicator()),
              )));
  }

  DropdownMenuItem<String> _buildMenuItem(UserModel item) {
    return DropdownMenuItem<String>(
        value: item.userId,
        child: Text(item.designation!,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)));
  }
}
