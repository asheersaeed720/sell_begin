import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:sell_begin/tab/view/tab_screen.dart';

class LandingScreen extends StatelessWidget {
  static const String routeName = '/';

  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Text('This is home Landing!'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.toNamed(TabsScreen.routeName);
            },
            child: Text('Go Home'),
          ),
        ],
      ),
    );
  }
}
