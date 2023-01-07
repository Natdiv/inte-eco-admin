import 'package:admin/controllers/auth_controller.dart';
import 'package:admin/models/user_data.dart';
import 'package:admin/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

class StationController extends GetxController {
  DataProvider _dataProvider = DataProvider();
  AuthController _authController = Get.put(AuthController());

  final _entreprises = <UserModel>[].obs;
  List<UserModel> get entreprises => _entreprises.value;

  final _stations = <Map<String, dynamic>>[].obs;
  List<Map<String, dynamic>> get stations => _stations.value;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;

  final _isStationsListLoaded = false.obs;
  bool get isStationsListLoaded => _isStationsListLoaded.value;
  set isStationsListLoaded(value) => _isStationsListLoaded.value = value;

  StationController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getStationByClient() async {
    _isStationsListLoaded.value = false;
    _stations.value = (await _dataProvider
        .getStationsByClient(_authController.currentAccount!.userId!))!;
    _isStationsListLoaded.value = true;
    // print("STATTIONS : ${_stations[0]['emplacement']}");
  }

  void getClientsList() async {
    _entreprises.value = await _dataProvider.getEntreprises();
  }

  void addStation(String uid, Map<String, dynamic> station) {
    this._isLoading.value = true;
    _dataProvider.addStation(uid, station).then((value) {
      // print("STATION ADDED");
      this._isLoading.value = false;
      Get.defaultDialog(
          title: 'Succès',
          middleText: "La station ${station["code"]} a été ajoutée avec succès",
          textConfirm: 'D\'accord',
          buttonColor: primaryColor,
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          });
    }).catchError((onError) {
      this._isLoading.value = false;
      // print("ERROR : $onError");
      Get.defaultDialog(
          title: 'Erreur',
          middleText: "Une erreur s'est produite lors de l'ajout de la station",
          textConfirm: 'D\'accord',
          buttonColor: primaryColor,
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          });
    });
  }
}
