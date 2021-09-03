import 'package:get/get.dart';
import 'package:sell_begin/auth/user.dart';

class AuthService extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://s-p.restncode.com/API/';
    super.onInit();
  }

  Future<Response> checkUser(UserModel user) {
    var loginFormData = FormData({
      'identifier': '${user.email}',
      'password': '${user.password}',
    });
    return post('Auth/checkuser', loginFormData, contentType: 'form-data');
  }

  Future<Response> loginUser(apiKey) => post('Auth/login', {}, headers: {'X-API-KEY': '$apiKey'});

  Future<Response> registerUser(UserModel user) {
    var signUpFormData = FormData({
      'name': '${user.fullName}',
      'email': '${user.email}',
      'phone': '${user.phoneNo}',
      'password': '${user.password}',
    });
    return post(
      'Auth/signup',
      signUpFormData,
    );
  }
}
