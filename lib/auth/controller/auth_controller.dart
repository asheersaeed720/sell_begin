import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sell_begin/auth/model/user.dart';

class AuthController extends GetxController {
  RxBool obscureText = true.obs;

  Rx<UserModel> userModel = UserModel().obs;
  Rx<String> imagePath = ''.obs;

  ImagePicker picker = ImagePicker();

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
}
