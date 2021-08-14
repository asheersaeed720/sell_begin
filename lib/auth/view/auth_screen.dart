import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:sell_begin/auth/view/phone_login_screen.dart';
import 'package:sell_begin/auth/view/signup_screen.dart';
import 'package:sell_begin/commons/widgets/custom_button.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // GoogleSignIn _googleSignIn = GoogleSignIn(
  //   scopes: [
  //     'email',
  //     'https://www.googleapis.com/auth/contacts.readonly',
  //   ],
  // );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(
                height: 200,
              ),
              Image.asset(
                'assets/images/logo.png',
                width: 120.0,
              ),
              const SizedBox(height: 62.0),
              CustomButton(
                width: double.infinity,
                btnColor: Theme.of(context).primaryColor,
                btnTxt: 'Continue with phone',
                iconImg: 'assets/icons/forward_arrow.png',
                onPressed: () {
                  Get.toNamed(PhoneLogInScreen.routeName);
                },
              ),
              const SizedBox(height: 10.0),
              CustomButton(
                width: double.infinity,
                btnColor: Theme.of(context).errorColor,
                btnTxt: 'Continue with google',
                iconImg: 'assets/icons/forward_arrow.png',
                onPressed: () async {
                  // await authPvd.signInWithGoogle().then(
                  //   (value) {
                  //     UserCredential aa = value;
                  //     print('${aa.user}');
                  //     UserFormData o = UserFormData(
                  //       email: aa.user!.email ?? "",
                  //       name: aa.user!.displayName ?? "",
                  //     );
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => SignUpScreen(
                  //             user: o,
                  //           ),
                  //         ));
                  //   },
                  // );
                },
              ),
              const SizedBox(height: 10.0),
              CustomButton(
                width: double.infinity,
                btnColor: Theme.of(context).accentColor,
                btnTxt: 'Create an account',
                iconImg: 'assets/icons/forward_arrow.png',
                onPressed: () {
                  Get.toNamed(SignUpScreen.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
