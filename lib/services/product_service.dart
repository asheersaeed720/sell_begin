import 'package:get/get.dart';

class ProductService extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://s-p.restncode.com/API/';
    super.onInit();
  }

  Future<Response> getProducts(apiKey) {
    return get('Item/search', headers: {'x-api-key': '$apiKey'});
  }
}
