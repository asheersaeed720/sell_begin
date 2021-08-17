import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_begin/commons/utils/input_decoration.dart';
import 'package:sell_begin/commons/widgets/product_item.dart';

class SearchProductScreen extends StatefulWidget {
  static const String routeName = '/search-product';

  const SearchProductScreen({Key? key}) : super(key: key);

  @override
  _SearchProductScreenState createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.0,
        title: Text('Search', style: TextStyle(fontSize: 16.0)),
      ),
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
                    const SizedBox(height: 14.0),
                    _buildLocationTextField(),
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

  Widget _buildLocationTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: InkWell(
        onTap: () {
          Get.toNamed(SearchProductScreen.routeName);
        },
        child: TextFormField(
          autofocus: true,
          decoration: buildTextFieldInputDecoration(context,
              prefixIconUrl: 'assets/icons/location.png', txt: 'City'),
        ),
      ),
    );
  }

  Widget _buildfindProductTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: InkWell(
        onTap: () {
          Get.toNamed(SearchProductScreen.routeName);
        },
        child: TextFormField(
          autofocus: true,
          decoration: buildTextFieldInputDecoration(context,
              prefixIconUrl: 'assets/icons/search.png', txt: 'Find your product'),
        ),
      ),
    );
  }
}
