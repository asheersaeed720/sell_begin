import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_begin/auth/auth_controller.dart';
import 'package:sell_begin/auth/views/login_screen.dart';
import 'package:sell_begin/location/location_controller.dart';
import 'package:sell_begin/location/views/select_location_screen.dart';
import 'package:sell_begin/tab/view/tab_screen.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _authController = Get.find<AuthController>();
  final _locationController = Get.find<LocationController>();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _authController.getUserData();
      _locationController.getLocation();
      if (_authController.userData.isEmpty) {
        Get.offNamed(LogInScreen.routeName);
      } else {
        if (_locationController.locationData.value.isEmpty) {
          Get.offNamed(SelectLocationScreen.routeName);
        } else {
          Get.offNamed(TabsScreen.routeName);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
