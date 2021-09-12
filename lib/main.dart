import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sell_begin/auth/auth_binding.dart';
import 'package:sell_begin/auth/views/auth_screen.dart';
import 'package:sell_begin/auth/views/login_screen.dart';
import 'package:sell_begin/auth/views/signup_screen.dart';
import 'package:sell_begin/chat/chat_binding.dart';
import 'package:sell_begin/chat/views/chat_detail_screen.dart';
import 'package:sell_begin/chat/views/chat_screen.dart';
import 'package:sell_begin/home/view/home_screen.dart';
import 'package:sell_begin/location/location_binding.dart';
import 'package:sell_begin/location/location_controller.dart';
import 'package:sell_begin/location/views/select_location_screen.dart';
import 'package:sell_begin/product/views/create_product_ad.dart';
import 'package:sell_begin/product/views/search_product_screen.dart';
import 'package:sell_begin/tab/view/tab_screen.dart';
import 'package:sell_begin/user_profile/view/user_profile_screen.dart';
import 'package:sell_begin/utils/app_theme.dart';

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
          GetPage(
            name: AuthScreen.routeName,
            page: () => AuthScreen(),
            bindings: [AuthBinding(), LocationBinding()],
          ),
          GetPage(
              name: HomeScreen.routeName,
              page: () => HomeScreen(),
              binding: LocationBinding()),
          GetPage(
              name: TabsScreen.routeName,
              page: () => TabsScreen(),
              binding: AuthBinding()),

          GetPage(
            name: LogInScreen.routeName,
            page: () => LogInScreen(),
            binding: AuthBinding(),
          ),
          GetPage(
              name: SignUpScreen.routeName,
              page: () => SignUpScreen(),
              binding: AuthBinding()),
          GetPage(
            name: SearchProductScreen.routeName,
            page: () => SearchProductScreen(),
            binding: LocationBinding(),
          ),
          GetPage(
            name: UserProfileScreen.routeName,
            page: () => UserProfileScreen(),
            binding: AuthBinding(),
          ),
          GetPage(
            name: ChatScreen.routeName,
            page: () => ChatScreen(),
            binding: ChatBinding(),
          ),
          GetPage(
            name: ChatDetailScreen.routeName,
            page: () => ChatDetailScreen(),
            binding: ChatBinding(),
          ),
          GetPage(
            name: CreateProductAdScreen.routeName,
            page: () => CreateProductAdScreen(),
          ),
          GetPage(
            name: SelectLocationScreen.routeName,
            page: () => SelectLocationScreen(),
            bindings: [AuthBinding(), LocationBinding()],
          ),
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
