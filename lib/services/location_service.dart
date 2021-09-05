import 'package:get/get.dart';

class LocationService extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://s-p.restncode.com/API/';
    super.onInit();
  }

  Future<Response> getCountriesList() {
    return get('Location/countries');
  }

  Future<Response> getStatesList(countryId) {
    return get('Location/states/$countryId');
  }

  Future<Response> getCitiesList(stateId) {
    return get('Location/cities/$stateId');
  }
}
