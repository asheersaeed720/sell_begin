import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sell_begin/auth/model/user.dart';
import 'package:sell_begin/auth/view/auth_screen.dart';
import 'package:sell_begin/commons/services/auth_service.dart';
import 'package:encrypt/encrypt.dart' as EncryptPack;

class AuthController extends GetxController {
  final _authService = Get.find<AuthService>();

  RxBool obscureText = true.obs;

  RxBool isLoading = false.obs;

  RxMap userData = Map().obs;

  Rx<UserModel> userModel = UserModel().obs;

  RxMap checkUserRes = RxMap();

  Rx<String> imagePath = ''.obs;

  ImagePicker picker = ImagePicker();

  @override
  void onInit() {
    ever(userModel, (val) {
      print(val);
    });
    super.onInit();
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera, imageQuality: 60);
    if (pickedFile != null) {
      // _image = File(pickedFile.path).obs;
      imagePath.value = pickedFile.path;
      print('picked: ${imagePath.value}');
    } else {
      print('No image selected.');
    }
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 60);

    if (pickedFile != null) {
      // _image = File(pickedFile.path).obs;
      imagePath.value = pickedFile.path;
      print('picked: ${imagePath.value}');
    } else {
      print('No image selected.');
    }
  }

  String generateApiKey() {
    final jsonString = '{"identifier": "${userModel.value.email}"}';
    final key = EncryptPack.Key.fromUtf8('aass2xQ5gk56hcFpd208U0AsI8mxaaoh');
    final iv = EncryptPack.IV.fromUtf8('asdzxcbdfbhessad');

    final encrypter = EncryptPack.Encrypter(EncryptPack.AES(key, mode: EncryptPack.AESMode.cbc));
    final encrypted = encrypter.encrypt(jsonString, iv: iv);
    return encrypted.base64;
  }

  checkUser() {
    isLoading.value = true;
    _authService.checkUser(userModel.value).then((res) async {
      log('${res.body}', name: 'res');
      if (res.statusCode == 200) {
        if (res.body['found']) {
          var apiKey = generateApiKey();
          var loginRes = await _authService.loginUser(apiKey);
          if (loginRes.statusCode == 200) {
            Map data = loginRes.body['user'];
            data['key'] = apiKey;
            GetStorage getStorage = GetStorage();
            getStorage.write('user', data);
            getUserData();
            Get.offNamed(AuthScreen.routeName);
          }
        }
      } else {
        Get.snackbar(
          'Error',
          "This User does'nt exist",
          margin: EdgeInsets.all(0),
          backgroundColor: Colors.red,
          colorText: Colors.white,
          icon: Icon(
            Icons.info,
            color: Colors.white,
          ),
          snackPosition: SnackPosition.BOTTOM,
          snackStyle: SnackStyle.GROUNDED,
          shouldIconPulse: true,
        );
      }
      isLoading.value = false;
    });
  }

  signUpUser() async {
    Response res = await _authService.registerUser(userModel.value);
    if (res.statusCode == 200) {}
  }

  getUserData() {
    userData.value = GetStorage().read('user') == null ? {} : GetStorage().read('user');
    log('$userData', name: 'stored_user');
  }

  void logoutUser() {
    GetStorage().remove('user');
    Get.offNamed(AuthScreen.routeName);
  }
}
