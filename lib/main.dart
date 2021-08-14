import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sell_begin/auth/binding/auth_binding.dart';
import 'package:sell_begin/auth/view/auth_screen.dart';
import 'package:sell_begin/auth/view/phone_login_screen.dart';
import 'package:sell_begin/auth/view/signup_screen.dart';
import 'package:sell_begin/commons/utils/app_theme.dart';
import 'package:sell_begin/home/view/home_screen.dart';
import 'package:sell_begin/landing/view/landing_screen.dart';
import 'package:sell_begin/tab/view/tab_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sell Begin',
        theme: ThemeData(
          primarySwatch: customPrimaryColor,
          accentColor: customAccentColor,
          errorColor: Colors.red[800],
          backgroundColor: AppTheme.COLOR_SCREEN_BG,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Poppins',
          textTheme: AppTheme.textTheme,
        ),
        // initialRoute: LandingScreen.routeName,
        initialRoute: AuthScreen.routeName,
        getPages: [
          GetPage(name: LandingScreen.routeName, page: () => LandingScreen()),
          GetPage(name: TabsScreen.routeName, page: () => TabsScreen()),
          GetPage(name: HomeScreen.routeName, page: () => HomeScreen()),
          GetPage(
            name: PhoneLogInScreen.routeName,
            page: () => PhoneLogInScreen(),
            binding: AuthBinding(),
          ),
          GetPage(name: SignUpScreen.routeName, page: () => SignUpScreen(), binding: AuthBinding()),
          GetPage(name: AuthScreen.routeName, page: () => AuthScreen()),
        ],
      );
}

Map<int, Color> color = {
  50: Color.fromRGBO(18, 0, 94, .1),
  100: Color.fromRGBO(18, 0, 94, .2),
  200: Color.fromRGBO(18, 0, 94, .3),
  300: Color.fromRGBO(18, 0, 94, .4),
  400: Color.fromRGBO(18, 0, 94, .5),
  500: Color.fromRGBO(18, 0, 94, .6),
  600: Color.fromRGBO(18, 0, 94, .7),
  700: Color.fromRGBO(18, 0, 94, .8),
  800: Color.fromRGBO(18, 0, 94, .9),
};

MaterialColor customPrimaryColor = MaterialColor(0xFF08558A, color);
MaterialColor customAccentColor = MaterialColor(0xFF0086e6, color);
