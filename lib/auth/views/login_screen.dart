import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sell_begin/auth/auth_controller.dart';
import 'package:sell_begin/auth/views/signup_screen.dart';
import 'package:sell_begin/utils/input_decoration.dart';
import 'package:sell_begin/widgets/custom_button.dart';
import 'package:sell_begin/widgets/loading_indicator.dart';

class LogInScreen extends StatefulWidget {
  static const String routeName = '/login';

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  GlobalKey<FormState> _formKeyLogin = GlobalKey<FormState>();

  final _authController = Get.find<AuthController>();

  final Map<String, dynamic> _args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKeyLogin,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset(
                  'assets/images/logo.png',
                  height: MediaQuery.of(context).size.height / 5.2,
                  fit: BoxFit.scaleDown,
                ),
              ),
              Text('Email'),
              const SizedBox(height: 10.0),
              _buildEmailTextField(),
              const SizedBox(height: 20.0),
              Text('Password'),
              const SizedBox(height: 10.0),
              _buildPasswordTextField(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Obx(
                () => _authController.isLoading.value
                    ? LoadingIndicator()
                    : CustomButton(
                        btnTxt: 'Login',
                        onPressed: () {
                          if (_formKeyLogin.currentState!.validate()) {
                            _formKeyLogin.currentState!.save();
                            FocusScopeNode currentFocus = FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            _authController.loginUser();
                          }
                        },
                      ),
              ),
              const SizedBox(height: 16.0),
              _buildOrDivider(),
              const SizedBox(height: 18.0),
              _buildSocialMediaIcon(),
              const SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account'),
                  const SizedBox(width: 8.0),
                  InkWell(
                    onTap: () {
                      Get.toNamed(SignUpScreen.routeName);
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailTextField() {
    _authController.userModel.update((val) {
      val!.email = _args.isEmpty ? '' : _args['email'].trim();
    });
    return TextFormField(
      initialValue: _args['email'],
      onChanged: (value) {
        _authController.userModel.update((val) {
          val!.email = value.trim();
        });
      },
      validator: (value) => value!.isEmpty ? "Required" : null,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: buildTextFieldInputDecoration(context, txt: 'Email'),
    );
  }

  // Widget _buildPhoneNoField() {
  //   return InternationalPhoneNumberInput(
  //     onInputChanged: (PhoneNumber number) {},
  //     selectorConfig: SelectorConfig(
  //       selectorType: PhoneInputSelectorType.DIALOG,
  //     ),
  //     validator: (value) {
  //       String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  //       RegExp regExp = new RegExp(patttern);
  //       if (value!.length == 0) {
  //         return 'Please enter mobile number';
  //       } else if (!regExp.hasMatch(value)) {
  //         return 'Please enter valid mobile number';
  //       }
  //       return null;
  //     },
  //     initialValue: PhoneNumber(isoCode: 'PK'),
  //     ignoreBlank: false,
  //     maxLength: 14,
  //     autoValidateMode: AutovalidateMode.disabled,
  //     selectorTextStyle: TextStyle(color: Colors.black),
  //     formatInput: false,
  //     inputBorder: OutlineInputBorder(),
  //     inputDecoration: buildTextFieldInputDecoration(context, txt: 'Mobile no'),
  //   );
  // }

  Widget _buildPasswordTextField() {
    return Obx(
      () => TextFormField(
        onChanged: (value) {
          _authController.userModel.update((val) {
            val!.password = value;
          });
        },
        obscureText: _authController.obscureText.value,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Required';
          } else if (_authController.userModel.value.password.length < 6) {
            return 'Too short';
          }
          return null;
        },
        keyboardType: TextInputType.visiblePassword,
        decoration: buildPasswordInputDecoration(
          context,
          txt: 'Password',
          suffixIcon: GestureDetector(
            onTap: () {
              _authController.obscureText.value = !_authController.obscureText.value;
            },
            child: Icon(
              _authController.obscureText.value ? Icons.visibility : Icons.visibility_off,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrDivider() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: <Color>[
                    Colors.grey.shade100,
                    Colors.grey,
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 1.0),
                  stops: <double>[0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            width: 100.0,
            height: 1.0,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Text(
              'Or',
              style: TextStyle(color: Colors.black, fontSize: 16.0),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: <Color>[
                    Colors.grey,
                    Colors.grey.shade100,
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 1.0),
                  stops: <double>[0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            width: 100.0,
            height: 1.0,
          ),
        ],
      ),
    );
  }

  Widget _buildSocialMediaIcon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          child: Container(
            padding: const EdgeInsets.all(14.0),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF0084ff),
            ),
            child: const Icon(
              FontAwesomeIcons.facebookF,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 34.0),
        GestureDetector(
          child: Container(
            padding: const EdgeInsets.all(14.0),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFE94034),
            ),
            child: const Icon(
              FontAwesomeIcons.google,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
