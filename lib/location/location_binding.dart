import 'package:get/get.dart';
import 'package:sell_begin/location/location_controller.dart';
import 'package:sell_begin/services/location_service.dart';

class LocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LocationService(), permanent: true);
    Get.put(LocationController(), permanent: true);
  }
}
