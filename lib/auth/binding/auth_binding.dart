import 'package:get/get.dart';
import 'package:sell_begin/auth/controller/auth_controller.dart';
import 'package:sell_begin/commons/services/auth_service.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthService());
    Get.put(AuthController());
  }
}
