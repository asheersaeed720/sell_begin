import 'package:get/get.dart';
import 'package:sell_begin/auth/auth_controller.dart';
import 'package:sell_begin/services/auth_service.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthService(), permanent: true);
    Get.put(AuthController(), permanent: true);
  }
}
