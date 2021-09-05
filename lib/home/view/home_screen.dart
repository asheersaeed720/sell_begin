import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:sell_begin/location/location_controller.dart';
import 'package:sell_begin/product/views/search_product_screen.dart';
import 'package:sell_begin/utils/input_decoration.dart';
import 'package:sell_begin/widgets/product_item.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';

  HomeScreen({Key? key}) : super(key: key);

  final _locationController = Get.find<LocationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              shadowColor: Colors.black87.withOpacity(0.5),
              pinned: false,
              snap: true,
              floating: true,
              expandedHeight: 148.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  children: [
                    const SizedBox(height: 14.0),
                    _buildLocationTextField(context),
                    const SizedBox(height: 8.0),
                    _buildfindProductTextField(context),
                    const Spacer(),
                    Image.asset('assets/images/divider.jpg'),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 10 / 13,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 12,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return ProductItem();
                  },
                  childCount: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: InkWell(
        onTap: () {
          Get.to(
            SearchProductScreen(),
            transition: Transition.leftToRight,
            duration: const Duration(milliseconds: 300),
          );
        },
        child: TextFormField(
          initialValue:
              '${_locationController.locationData.value['countryName']}, ${_locationController.locationData.value['cityName']}',
          enabled: false,
          decoration: buildTextFieldInputDecoration(context,
              prefixIconUrl: 'assets/icons/location.png', txt: 'City'),
        ),
      ),
    );
  }

  Widget _buildfindProductTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: InkWell(
        onTap: () {
          Get.to(
            SearchProductScreen(),
            transition: Transition.leftToRight,
            duration: const Duration(milliseconds: 300),
          );
        },
        child: TextFormField(
          enabled: false,
          decoration: buildTextFieldInputDecoration(context,
              prefixIconUrl: 'assets/icons/search.png', txt: 'Find your product'),
        ),
      ),
    );
  }
}
