import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:sell_begin/location/location_controller.dart';
import 'package:sell_begin/location/models/city.dart';
import 'package:sell_begin/utils/input_decoration.dart';
import 'package:sell_begin/widgets/custom_app_bar.dart';

class SearchProductScreen extends StatefulWidget {
  static const String routeName = '/search-product';

  const SearchProductScreen({Key? key}) : super(key: key);

  @override
  _SearchProductScreenState createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  final _locationController = Get.find<LocationController>();

  final TextEditingController _typeCityIdAheadController = TextEditingController();
  final TextEditingController _typeCityAheadController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _locationController.getCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: customAppBar('Search'),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              shadowColor: Colors.black87.withOpacity(0.5),
              pinned: false,
              snap: true,
              floating: true,
              automaticallyImplyLeading: false,
              expandedHeight: 136.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  children: [
                    _buildCityDropDown(),
                    const SizedBox(height: 8.0),
                    _buildfindProductTextField(),
                    const Spacer(),
                    Image.asset('assets/images/divider.jpg'),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 250.0),
            ),
            const SliverToBoxAdapter(
              child: Center(child: Text('Search Result Here')),
            ),
            // SliverPadding(
            //   padding: EdgeInsets.symmetric(horizontal: 8.0),
            //   sliver: SliverGrid(
            //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 2,
            //       childAspectRatio: 10 / 13,
            //       crossAxisSpacing: 10,
            //       mainAxisSpacing: 12,
            //     ),
            //     delegate: SliverChildBuilderDelegate(
            //       (BuildContext context, int index) {
            //         return Text('Search Result');
            //       },
            //       childCount: 12,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildCityDropDown() {
    setState(() {
      _typeCityAheadController.text = '${_locationController.locationData.value['cityName']}';
    });

    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
        controller: this._typeCityAheadController,
        decoration: buildTextFieldInputDecoration(context,
            prefixIconUrl: 'assets/icons/location.png', txt: 'City'),
      ),
      suggestionsCallback: (pattern) async {
        return _locationController.getCitySuggestions(pattern);
      },
      itemBuilder: (context, CityModel suggestion) {
        return ListTile(
          leading: Icon(Icons.location_city),
          title: Text('${suggestion.name}'),
        );
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      onSuggestionSelected: (CityModel suggestion) {
        this._typeCityIdAheadController.text = '${suggestion.id}';
        this._typeCityAheadController.text = '${suggestion.name}';
      },
    );
  }

  Widget _buildfindProductTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(
        autofocus: true,
        decoration: buildTextFieldInputDecoration(context,
            prefixIconUrl: 'assets/icons/search.png', txt: 'Find your product'),
      ),
    );
  }
}
