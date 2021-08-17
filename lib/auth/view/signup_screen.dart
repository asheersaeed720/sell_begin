import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sell_begin/auth/controller/auth_controller.dart';
import 'package:sell_begin/commons/utils/input_decoration.dart';
import 'package:sell_begin/commons/widgets/custom_button.dart';
import 'package:sell_begin/tab/view/tab_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/sign-up';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> _formKeySignup = GlobalKey<FormState>();

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKeySignup,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfilePic(),
                const SizedBox(height: 10.0),
                Text('Email'),
                const SizedBox(height: 10.0),
                _buildEmailTextField(),
                const SizedBox(height: 20.0),
                Text('Mobile'),
                const SizedBox(height: 10.0),
                _buildPhoneNoField(),
                const SizedBox(height: 20.0),
                Text('Password'),
                const SizedBox(height: 10.0),
                _buildPasswordTextField(),
                const SizedBox(height: 20.0),
                Text('Confirm Password'),
                const SizedBox(height: 10.0),
                _buildConfirmPasswordTextField(),
                SizedBox(height: 22),
                CustomButton(
                  width: double.infinity,
                  btnTxt: 'Signup',
                  onPressed: () async {
                    // if (_formKeySignup.currentState!.validate()) {
                    //   _formKeySignup.currentState!.save();
                    //   if (authPvd.image != null) {
                    //     FocusScopeNode currentFocus = FocusScope.of(context);
                    //     if (!currentFocus.hasPrimaryFocus) {
                    //       currentFocus.unfocus();
                    //     }
                    //     authPvd.phoneNoVerification(context, authPvd.userFormData);
                    //   } else {
                    //     Get.sn
                    //     customToast('profile_pic_required');
                    //   }
                    // }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePic() {
    return Container(
      margin: EdgeInsets.only(top: 25.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        shape: BoxShape.circle,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: Image.asset(
              'assets/images/profile_img.png',
              // width: 120.0,
              height: 124.0,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      onChanged: (value) {
        authController.userModel.update((val) {
          val!.email = value.trim();
        });
      },
      validator: (value) => value!.isEmpty ? "Required" : null,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: buildTextFieldInputDecoration(context, txt: 'Email'),
    );
  }

  Widget _buildPhoneNoField() {
    return InternationalPhoneNumberInput(
      onInputChanged: (PhoneNumber number) {
        authController.userModel.update((val) {
          val!.phoneNo = number.phoneNumber!.trim();
        });
      },
      selectorConfig: SelectorConfig(
        selectorType: PhoneInputSelectorType.DIALOG,
      ),
      validator: (value) {
        String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
        RegExp regExp = new RegExp(patttern);
        if (value!.length == 0) {
          return 'Please enter mobile number';
        } else if (!regExp.hasMatch(value)) {
          return 'Please enter valid mobile_number';
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
      inputDecoration: buildTextFieldInputDecoration(context, txt: 'Phone No'),
    );
  }

  Widget _buildPasswordTextField() {
    return Obx(
      () => TextFormField(
        onChanged: (value) {
          authController.userModel.update((val) {
            val!.password = value;
          });
        },
        obscureText: authController.obscureText.value,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Required';
          } else if (authController.userModel.value.password.length < 6) {
            return 'too Short';
          }
          return null;
        },
        keyboardType: TextInputType.visiblePassword,
        decoration: buildPasswordInputDecoration(
          context,
          txt: 'Password',
          suffixIcon: GestureDetector(
            onTap: () {
              authController.obscureText.toggle();
            },
            child: Icon(
              authController.obscureText.value ? Icons.visibility : Icons.visibility_off,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmPasswordTextField() {
    return Obx(
      () => TextFormField(
        onChanged: (value) {
          authController.userModel.update((val) {
            val!.confirmPassword = value;
          });
        },
        obscureText: authController.obscureText.value,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Required';
          } else if (authController.userModel.value.password !=
              authController.userModel.value.confirmPassword) {
            return 'please match password';
          }
          return null;
        },
        keyboardType: TextInputType.visiblePassword,
        decoration: buildPasswordInputDecoration(
          context,
          txt: 'Confirm password',
          suffixIcon: GestureDetector(
            onTap: () {
              authController.obscureText.toggle();
            },
            child: new Icon(
              authController.obscureText.value ? Icons.visibility : Icons.visibility_off,
            ),
          ),
        ),
      ),
    );
  }
}
