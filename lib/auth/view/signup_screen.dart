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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKeySignup,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfilePic(),
                const SizedBox(height: 35),
                Text('Email'),
                const SizedBox(
                  height: 10.0,
                ),
                _buildEmailTextField(),
                const SizedBox(
                  height: 20.0,
                ),
                Text('Mobile'),
                const SizedBox(
                  height: 10.0,
                ),
                _buildPhoneNoField(),
                const SizedBox(
                  height: 20.0,
                ),
                Text('Password'),
                const SizedBox(
                  height: 10.0,
                ),
                _buildPasswordTextField(),
                const SizedBox(
                  height: 20.0,
                ),
                Text('Confirm Password'),
                const SizedBox(
                  height: 10.0,
                ),
                _buildConfirmPasswordTextField(),
                SizedBox(height: 22),
                CustomButton(
                  width: double.infinity,
                  btnTxt: 'Signup',
                  onPressed: () async {
                    Get.toNamed(TabsScreen.routeName);
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
        border: Border.all(color: Theme.of(context).primaryColor, width: 1.5),
        shape: BoxShape.circle,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Obx(
            () => ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: authController.imagePath.value.isEmpty
                  ? Image.asset(
                      'assets/images/dummy_profile.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.fill,
                    )
                  : Image.file(File(authController.imagePath.value),
                      width: 100, height: 100, fit: BoxFit.cover),
            ),
          ),
          Positioned(
            bottom: 0,
            right: -5,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              radius: 14,
              child: IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext bc) {
                      return SafeArea(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(10.0),
                                topRight: const Radius.circular(10.0)),
                          ),
                          child: Wrap(
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.photo_camera),
                                title: Text('Camera'),
                                onTap: () {
                                  authController.getImageFromCamera();
                                  Navigator.of(context).pop();
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.photo_library),
                                title: Text('Gallery'),
                                onTap: () {
                                  authController.getImageFromGallery();
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                padding: EdgeInsets.all(0),
                icon: Icon(Icons.edit, color: Colors.white, size: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      onChanged: (value) {
        authController.userModel.value.email = value;
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
        authController.userModel.value.phoneNo = '${number.phoneNumber}';
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
          authController.userModel.value.password = value;
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
          authController.userModel.value.confirmPassword = value;
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
