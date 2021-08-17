import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_begin/auth/controller/auth_controller.dart';
import 'package:sell_begin/auth/view/login_screen.dart';
import 'package:sell_begin/tab/view/tab_screen.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _authController = Get.find<AuthController>();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _authController.getUserData();
      var data = _authController.userData;
      if (data.isEmpty) {
        Get.offNamed(LogInScreen.routeName);
      } else {
        Get.offNamed(TabsScreen.routeName);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body: Center(
        //   child: Text('loading...'),
        // ),
        );
  }
}
