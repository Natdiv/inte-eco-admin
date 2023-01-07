import 'package:inte_eco_admin/models/user_data.dart';
import 'package:inte_eco_admin/providers/data_provider.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

class UserController extends GetxController {
  DataProvider _dataProvider = DataProvider();

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  UserController();

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

  bool ajouterClient(UserModel userModel) {
    return false;
  }

  addUser(UserModel userModel) {
    _isLoading.value = true;
    _dataProvider
        .createUserWithEmailAndPassword(userModel.email!, userModel.password!)
        .then((HttpsCallableResult value) async {
      if (value.data['success'] == true) {
        try {
          userModel.userId = value.data['uid'];
          await _dataProvider.addUser(userModel);
          _isLoading.value = false;
          Get.defaultDialog(
              title: 'Succès',
              middleText: value.data['message'],
              textConfirm: 'D\'accord',
              buttonColor: primaryColor,
              confirmTextColor: Colors.white,
              onConfirm: () {
                Get.back();
              });
        } catch (e) {
          _isLoading.value = false;
          // print(e);
          Get.defaultDialog(
              title: 'Erreur',
              middleText:
                  "Une erreur s'est produite lors de l'ajout de l'utilisateur",
              textConfirm: 'D\'accord',
              buttonColor: primaryColor,
              confirmTextColor: Colors.white,
              onConfirm: () {
                Get.back();
              });
        }
      } else {
        // print(value.data['message']);
        _isLoading.value = false;
        Get.defaultDialog(
            title: 'Erreur',
            middleText:
                "Une erreur s'est produite lors de l'ajout de l'utilisateur",
            textConfirm: 'D\'accord',
            buttonColor: primaryColor,
            confirmTextColor: Colors.white,
            onConfirm: () {
              Get.back();
            });
      }
    }).catchError((e) {
      _isLoading.value = false;
      // print('Une erreur inconnue est survenue $e');
    });
  }
}
