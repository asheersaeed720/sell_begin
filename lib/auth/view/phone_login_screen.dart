import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sell_begin/auth/controller/auth_controller.dart';
import 'package:sell_begin/auth/view/signup_screen.dart';
import 'package:sell_begin/commons/utils/input_decoration.dart';
import 'package:sell_begin/commons/widgets/custom_button.dart';

class PhoneLogInScreen extends StatefulWidget {
  static const String routeName = '/phone-auth';

  @override
  _PhoneLogInScreenState createState() => _PhoneLogInScreenState();
}

class _PhoneLogInScreenState extends State<PhoneLogInScreen> {
  GlobalKey<FormState> _formKeyLogin = GlobalKey<FormState>();

  final authController = Get.find<AuthController>();

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
                  'assets/images/smartphone.png',
                  height: MediaQuery.of(context).size.height / 4.5,
                  fit: BoxFit.scaleDown,
                ),
              ),
              const SizedBox(height: 32),
              Text('Mobile no'),
              const SizedBox(height: 10.0),
              _buildPhoneNoField(),
              const SizedBox(height: 20.0),
              Text('Password'),
              const SizedBox(height: 10.0),
              _buildPasswordTextField(),
              const SizedBox(height: 22),
              CustomButton(
                btnTxt: 'Login',
                onPressed: () {
                  if (_formKeyLogin.currentState!.validate()) {
                    _formKeyLogin.currentState!.save();
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.unfocus();
                    }
                    // authPvd.checkUser(context);
                  }
                },
              ),
              const SizedBox(height: 22.0),
              Row(
                children: [
                  Text('Don\'t have account'),
                  const SizedBox(width: 8.0),
                  InkWell(
                    onTap: () {
                      Get.toNamed(SignUpScreen.routeName);
                    },
                    child: Text(
                      'Signup',
                      style: TextStyle(
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

  Widget _buildPhoneNoField() {
    return InternationalPhoneNumberInput(
      onInputChanged: (PhoneNumber number) {},
      selectorConfig: SelectorConfig(
        selectorType: PhoneInputSelectorType.DIALOG,
      ),
      validator: (value) {
        String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
        RegExp regExp = new RegExp(patttern);
        if (value!.length == 0) {
          return 'Please enter mobile number';
        } else if (!regExp.hasMatch(value)) {
          return 'Please enter valid mobile number';
        }
        return null;
      },
      initialValue: PhoneNumber(isoCode: 'PK'),
      ignoreBlank: false,
      maxLength: 14,
      autoValidateMode: AutovalidateMode.disabled,
      selectorTextStyle: TextStyle(color: Colors.black),
      formatInput: false,
      inputBorder: OutlineInputBorder(),
      inputDecoration: buildTextFieldInputDecoration(context, hintText: 'Mobile no'),
    );
  }

  Widget _buildPasswordTextField() {
    return Obx(
      () => TextFormField(
        onChanged: (value) {
          authController.userModel.value.password = value;
        },
        obscureText: authController.obscureText.value,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Required';
          } else if (authController.userModel.value.password.length < 6) {
            return 'Too short';
          }
          return null;
        },
        keyboardType: TextInputType.visiblePassword,
        decoration: buildPasswordInputDecoration(
          context,
          hintText: 'Password',
          suffixIcon: GestureDetector(
            onTap: () {
              authController.obscureText.value = !authController.obscureText.value;
            },
            child: Icon(
              authController.obscureText.value ? Icons.visibility : Icons.visibility_off,
            ),
          ),
        ),
      ),
    );
  }
}
