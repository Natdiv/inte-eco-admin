import 'package:admin/models/user_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:firebase_auth/firebase_auth.dart';
import '../constants.dart';
import '../providers/data_provider.dart';

import '../routes/app_pages.dart';

class AuthController extends GetxController {
  // static AuthController instance = Get.find();

  final DataProvider _dataProvider = DataProvider();

  final _isLoading = false.obs;
  get isLoading => _isLoading.value;

  final _isSigningIn = false.obs;
  get isSigningIn => _isSigningIn.value;

  final _currentAccount = UserModel().obs;
  UserModel? get currentAccount => _currentAccount.value;

  // Firebase User
  late Rx<User?> _user;

  // Firebase instance
  FirebaseAuth _auth = FirebaseAuth.instance;

  // get userName => _user.value?.displayName;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    // _auth.currentUser?.reload();

    _user = Rx<User?>(_auth.currentUser);
    _user.bindStream(_auth.authStateChanges());

    ever(_user, _initialScreen);
  }

  @override
  void onClose() {
    super.onClose();
  }

  _initialScreen(User? user) async {
    if (user == null) {
      Get.offAllNamed(Routes.SIGNIN);
      // _currentAccount.close();
    } else {
      // print('User is already logged in $user');

      _currentAccount.value =
          (await _dataProvider.getUserById(_auth.currentUser!.uid))!;
      _isSigningIn.value = true;

      Get.offAllNamed(Routes.HOME);
    }
  }

  void login(String email, password) async {
    try {
      _isLoading.value = true;
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      // Get.offAllNamed(Routes.HOME);

      _isLoading.value = false;
    } on FirebaseAuthException catch (error) {
      print(error.message);
      var errorCode;
      _isLoading.value = false;

      switch (error.code) {
        case 'user-not-found':
          errorCode = 'Aucun utilisateur trouvé pour cet email';
          break;
        case 'wrong-password':
          errorCode = 'Mot de passe incorrect';
          break;
        case 'invalid-email':
          errorCode = 'Email invalide';
          break;
        default:
          errorCode = 'Une erreur est survenue';
      }

      Get.defaultDialog(
          middleText: errorCode,
          textConfirm: 'D\'accord',
          buttonColor: primaryColor,
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          });
    }
  }

  void signOut() async {
    _isSigningIn.value = true;
    await _auth.signOut();
  }
}
