import 'package:get/get.dart';
import 'package:sell_begin/auth/model/user.dart';

class AuthService extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://s-p.restncode.com/API/';
    super.onInit();
  }

  Future<Response> checkUser(UserModel user) {
    var formData = FormData({
      'identifier': '${user.email}',
      'password': '${user.password}',
    });
    return post('Auth/checkuser', formData, contentType: 'form-data');
  }

  Future<Response> loginUser(apiKey) => post('Auth/login', {}, headers: {'X-API-KEY': '$apiKey'});

  // Future<Response> loginUser(UserModel data) => post(
  //       '/checkUser',
  //       {
  //         'identifier': '${data.email}',
  //         'password': '${data.password}',
  //       },
  //     );
}
