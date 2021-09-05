import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sell_begin/location/models/city.dart';
import 'package:sell_begin/location/models/country.dart';
import 'package:sell_begin/location/models/state.dart';
import 'package:sell_begin/services/location_service.dart';
import 'package:sell_begin/tab/view/tab_screen.dart';

class LocationController extends GetxController {
  final _locationService = Get.find<LocationService>();

  final countriesList = Rx<List<CountryModel>>([]);
  final statesList = Rx<List<CountryStateModel>>([]);
  final citiesList = Rx<List<CityModel>>([]);

  final locationData = Rx<Map<String, dynamic>>({});

  Future<List<CountryModel>> getCountries() async {
    statesList.value = [];
    citiesList.value = [];
    if (countriesList.value.isNotEmpty) return countriesList.value;
    var response = await _locationService.getCountriesList();
    if (response.statusCode == 200) {
      response.body.forEach((res) => countriesList.value.add(CountryModel.fromJson(res)));
      print(response.body);
    }
    return countriesList.value;
  }

  List<CountryModel> getCountrySuggestions(String query) {
    List<CountryModel> matches = <CountryModel>[];
    matches.addAll(countriesList.value);

    matches.retainWhere((s) => s.name!.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  Future<List<CountryStateModel>> getStates(countryId) async {
    var response = await _locationService.getStatesList(countryId);
    if (response.statusCode == 200) {
      statesList.value = [];
      response.body.forEach((res) => statesList.value.add(CountryStateModel.fromJson(res)));
      print(response.body);
    }
    return statesList.value;
  }

  List<CountryStateModel> getStateSuggestions(String query) {
    List<CountryStateModel> matches = <CountryStateModel>[];
    matches.addAll(statesList.value);

    matches.retainWhere((s) => s.name!.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  Future<List<CityModel>> getCities(stateId) async {
    var response = await _locationService.getCitiesList(stateId);
    if (response.statusCode == 200) {
      citiesList.value = [];
      response.body.forEach((res) => citiesList.value.add(CityModel.fromJson(res)));
      print(response.body);
    }
    return citiesList.value;
  }

  List<CityModel> getCitySuggestions(String query) {
    List<CityModel> matches = <CityModel>[];
    matches.addAll(citiesList.value);

    matches.retainWhere((s) => s.name!.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  saveLocation(countryId, countryName, stateId, stateName, cityId, cityName) {
    var data = {
      'countryId': '$countryId',
      'countryName': '$countryName',
      'stateId': '$stateId',
      'stateName': '$stateName',
      'cityId': '$cityId',
      'cityName': '$cityName',
    };
    GetStorage().write('locationData', data);
    getLocation();
    Get.offAndToNamed(TabsScreen.routeName);
  }

  getLocation() {
    locationData.value =
        GetStorage().read('locationData') == null ? {} : GetStorage().read('locationData');
    log('${locationData.value}', name: 'location');
  }
}
