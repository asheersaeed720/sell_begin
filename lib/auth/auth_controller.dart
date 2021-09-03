import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sell_begin/auth/user.dart';
import 'package:sell_begin/auth/views/auth_screen.dart';
import 'package:sell_begin/services/auth_service.dart';
import 'package:encrypt/encrypt.dart' as EncryptPack;
import 'package:sell_begin/utils/custom_snack_bar.dart';

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
        customSnackBar('Error', 'Invalid Credential');
      }
      isLoading.value = false;
    });
  }

  signUpUser() async {
    isLoading.value = true;
    var res = await _authService.registerUser(userModel.value);
    log('${res.body}', name: 'res');
    if (res.statusCode == 200) {
      var apiKey = generateApiKey();
      Map data = res.body['user'];
      data['key'] = apiKey;
      GetStorage().write('user', data);
      getUserData();
      Get.offNamedUntil(AuthScreen.routeName, (route) => false);
    } else {
      customSnackBar('Error', 'This User already exist');
    }
    isLoading.value = false;
  }

  getUserData() {
    userData.value = GetStorage().read('user') == null ? {} : GetStorage().read('user');
    log('$userData', name: 'stored_user');
  }

  logoutUser() {
    GetStorage().remove('user');
    Get.offNamed(AuthScreen.routeName);
  }
}
