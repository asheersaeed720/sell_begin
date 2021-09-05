import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:sell_begin/location/location_controller.dart';
import 'package:sell_begin/location/models/city.dart';
import 'package:sell_begin/location/models/country.dart';
import 'package:sell_begin/location/models/state.dart';
import 'package:sell_begin/tab/view/tab_screen.dart';
import 'package:sell_begin/utils/display_toast_message.dart';
import 'package:sell_begin/utils/input_decoration.dart';
import 'package:sell_begin/widgets/custom_app_bar.dart';
import 'package:sell_begin/widgets/custom_button.dart';

class SelectLocationScreen extends StatefulWidget {
  static const String routeName = '/select-location';

  const SelectLocationScreen({Key? key}) : super(key: key);

  @override
  _SelectLocationScreenState createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  LocationController _locationController = Get.find<LocationController>();

  GlobalKey<FormState> _formKeyLocationForm = GlobalKey<FormState>();

  final TextEditingController _typeCountryIdAheadController = TextEditingController();
  final TextEditingController _typeCountryAheadController = TextEditingController();
  final TextEditingController _typeStateIdAheadController = TextEditingController();
  final TextEditingController _typeStateAheadController = TextEditingController();
  final TextEditingController _typeCityIdAheadController = TextEditingController();
  final TextEditingController _typeCityAheadController = TextEditingController();

  //* value == typeController

  @override
  void initState() {
    super.initState();
    _locationController.getCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Select Location'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKeyLocationForm,
            child: Column(
              children: [
                _buildCountryStateDropDown(),
                const SizedBox(height: 16.0),
                _buildCityDropDown(),
                const SizedBox(height: 16.0),
                CustomButton(
                  width: double.infinity,
                  btnTxt: 'Next >',
                  onPressed: () {
                    if (_typeCountryAheadController.text.isNotEmpty &&
                        _typeStateAheadController.text.isNotEmpty &&
                        _typeCityAheadController.text.isNotEmpty) {
                      _locationController.saveLocation(
                        _typeCountryIdAheadController.text,
                        _typeCountryAheadController.text,
                        _typeStateIdAheadController.text,
                        _typeStateAheadController.text,
                        _typeCityIdAheadController.text,
                        _typeCityAheadController.text,
                      );
                    } else {
                      displayToastMessage('Select Location');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCountryStateDropDown() {
    return Row(
      children: [
        Flexible(
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              autofocus: true,
              controller: this._typeCountryAheadController,
              onChanged: (_) {
                setState(() {});
              },
              decoration: buildTextFieldInputDecoration(
                context,
                prefixIconUrl: 'assets/icons/globe.png',
                suffixIconUrl:
                    this._typeCountryAheadController.text.isEmpty ? '' : 'assets/icons/cancel.png',
                suffixFunction: () {
                  _locationController.statesList.value = [];
                  _locationController.citiesList.value = [];
                  this._typeCountryIdAheadController.text = '';
                  this._typeCountryAheadController.text = '';
                  this._typeStateIdAheadController.text = '';
                  this._typeStateAheadController.text = '';
                  this._typeCityIdAheadController.text = '';
                  this._typeCityAheadController.text = '';
                  setState(() {});
                },
                txt: 'Country',
              ),
            ),
            getImmediateSuggestions: true,
            suggestionsCallback: (pattern) async {
              return _locationController.getCountrySuggestions(pattern);
            },
            itemBuilder: (context, CountryModel suggestion) {
              return ListTile(
                leading: Icon(Icons.location_city),
                title: Text('${suggestion.name}'),
              );
            },
            transitionBuilder: (context, suggestionsBox, controller) {
              print(controller);
              print(suggestionsBox);
              return suggestionsBox;
            },
            onSuggestionSelected: (CountryModel suggestion) {
              _locationController.getStates(suggestion.id);
              this._typeCountryIdAheadController.text = '${suggestion.id}';
              this._typeCountryAheadController.text = '${suggestion.name}';
              this._typeStateIdAheadController.text = '';
              this._typeStateAheadController.text = '';
              this._typeCityIdAheadController.text = '';
              this._typeCityAheadController.text = '';
              setState(() {});
            },
          ),
        ),
        const SizedBox(width: 8.0),
        Flexible(
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              controller: this._typeStateAheadController,
              onChanged: (value) {
                if (value.isEmpty) {
                  this._typeStateIdAheadController.text = '';
                  this._typeStateAheadController.text = '';
                }
              },
              decoration: buildTextFieldInputDecoration(context,
                  prefixIconUrl: 'assets/icons/location.png', txt: 'State'),
            ),
            getImmediateSuggestions: true,
            suggestionsCallback: (pattern) async {
              return _locationController.getStateSuggestions(pattern);
            },
            itemBuilder: (context, CountryStateModel suggestion) {
              return ListTile(
                leading: Icon(Icons.location_city),
                title: Text(suggestion.name.toString()),
              );
            },
            transitionBuilder: (context, suggestionsBox, controller) {
              print(controller);
              print(suggestionsBox);
              return suggestionsBox;
            },
            onSuggestionSelected: (CountryStateModel suggestion) {
              _locationController.getCities(suggestion.id);
              this._typeStateIdAheadController.text = '${suggestion.id}';
              this._typeStateAheadController.text = '${suggestion.name}';
              this._typeCityIdAheadController.text = '';
              this._typeCityAheadController.text = '';
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCityDropDown() {
    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
        controller: this._typeCityAheadController,
        onChanged: (value) {
          if (value.isEmpty) {
            this._typeCityIdAheadController.text = '';
            this._typeCityAheadController.text = '';
          }
        },
        decoration: buildTextFieldInputDecoration(context,
            prefixIconUrl: 'assets/icons/city_location.png', txt: 'City'),
      ),
      getImmediateSuggestions: true,
      suggestionsCallback: (pattern) async {
        return _locationController.getCitySuggestions(pattern);
      },
      itemBuilder: (context, CityModel suggestion) {
        return ListTile(
          leading: Icon(Icons.location_city),
          title: Text(suggestion.name.toString()),
        );
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        print(controller);
        print(suggestionsBox);
        return suggestionsBox;
      },
      onSuggestionSelected: (CityModel suggestion) {
        this._typeCityIdAheadController.text = '${suggestion.id}';
        this._typeCityAheadController.text = '${suggestion.name}';
      },
    );
  }
}
