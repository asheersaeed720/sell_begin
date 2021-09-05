import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_begin/chat/views/chat_screen.dart';
import 'package:sell_begin/home/view/home_screen.dart';
import 'package:sell_begin/product/views/create_product_ad.dart';
import 'package:sell_begin/user_profile/view/user_profile_screen.dart';

class TabsScreen extends StatefulWidget {
  static const String routeName = '/tab';

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  PageController? _pageController;
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: <Widget>[
          HomeScreen(),
          ChatScreen(),
          CreateProductAdScreen(),
          CreateProductAdScreen(),
          UserProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(width: 7),
            IconButton(
              icon: Icon(
                Icons.home,
                size: 24.0,
              ),
              color: _page == 0
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).textTheme.caption!.color,
              onPressed: () => _pageController!.jumpToPage(0),
            ),
            IconButton(
              icon: Icon(
                Icons.chat_bubble_outline,
                size: 24.0,
              ),
              color: _page == 1
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).textTheme.caption!.color,
              onPressed: () => _pageController!.jumpToPage(1),
            ),
            IconButton(
              icon: Icon(
                Icons.expand_less,
                size: 24.0,
                color: Theme.of(context).primaryColor,
              ),
              color: _page == 2
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).textTheme.caption!.color,
              onPressed: () => _pageController!.jumpToPage(2),
            ),
            IconButton(
              icon: Icon(
                Icons.favorite,
                size: 24.0,
              ),
              color: _page == 3
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).textTheme.caption!.color,
              onPressed: () => _pageController!.jumpToPage(3),
            ),
            IconButton(
              icon: Icon(
                Icons.account_box,
              ),
              color: _page == 4
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).textTheme.caption!.color,
              onPressed: () => _pageController!.jumpToPage(4),
            ),
            SizedBox(width: 7),
          ],
        ),
        // color: Theme.of(context).primaryColor,
        shape: CircularNotchedRectangle(),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 4.0,
        disabledElevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => _pageController!.jumpToPage(2),
      ),
    );
  }

  void navigationTapped(int page) {
    _pageController!.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
}
