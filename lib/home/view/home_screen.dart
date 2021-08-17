import 'package:flutter/material.dart';
import 'package:sell_begin/commons/widgets/product_item.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.blueGrey.withOpacity(0.3),
              shadowColor: Colors.blueGrey.withOpacity(0.5),
              pinned: false,
              snap: true,
              floating: true,
              expandedHeight: 142.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Text('Search Box Here'),
                    ],
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 10.0),
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
}
