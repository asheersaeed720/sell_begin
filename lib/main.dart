import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sell_begin/auth/binding/auth_binding.dart';
import 'package:sell_begin/auth/view/auth_screen.dart';
import 'package:sell_begin/auth/view/login_screen.dart';
import 'package:sell_begin/auth/view/signup_screen.dart';
import 'package:sell_begin/commons/utils/app_theme.dart';
import 'package:sell_begin/home/view/home_screen.dart';
import 'package:sell_begin/search_product/view/search_product_screen.dart';
import 'package:sell_begin/tab/view/tab_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
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
          backgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Poppins',
          textTheme: AppTheme.textTheme,
        ),
        initialRoute: AuthScreen.routeName,
        getPages: [
          GetPage(name: AuthScreen.routeName, page: () => AuthScreen(), binding: AuthBinding()),
          GetPage(name: TabsScreen.routeName, page: () => TabsScreen(), binding: AuthBinding()),
          GetPage(name: HomeScreen.routeName, page: () => HomeScreen()),
          GetPage(
            name: LogInScreen.routeName,
            page: () => LogInScreen(),
            binding: AuthBinding(),
          ),
          GetPage(name: SignUpScreen.routeName, page: () => SignUpScreen(), binding: AuthBinding()),
          GetPage(name: SearchProductScreen.routeName, page: () => SearchProductScreen()),
        ],
      );
}

Map<int, Color> color = {
  50: Color.fromRGBO(255, 153, 0, .1),
  100: Color.fromRGBO(255, 153, 0, .2),
  200: Color.fromRGBO(255, 153, 0, .3),
  300: Color.fromRGBO(255, 153, 0, .4),
  400: Color.fromRGBO(255, 153, 0, .5),
  500: Color.fromRGBO(255, 153, 0, .6),
  600: Color.fromRGBO(255, 153, 0, .7),
  700: Color.fromRGBO(255, 153, 0, .8),
  800: Color.fromRGBO(255, 153, 0, .9),
};

MaterialColor customPrimaryColor = MaterialColor(0xFFFF9900, color);
MaterialColor customAccentColor = MaterialColor(0xFFffb340, color);
