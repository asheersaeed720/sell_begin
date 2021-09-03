import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_begin/auth/auth_controller.dart';
import 'package:sell_begin/utils/custom_dialog.dart';

class UserProfileScreen extends StatelessWidget {
  static const String routeName = '/user-profile';

  UserProfileScreen({Key? key}) : super(key: key);

  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).accentColor,
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 48, left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My profile',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                GestureDetector(
                  onTap: () {
                    showAlertDialog(
                      context,
                      'logout',
                      'Are you sure?',
                      () {
                        _authController.logoutUser();
                      },
                    );
                  },
                  child: Icon(Icons.exit_to_app, color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 72),
            child: Column(
              children: [
                Column(
                  children: [
                    _buildProfilePic(context),
                    const SizedBox(height: 8.0),
                    Text(
                      'test',
                      style: TextStyle(color: Color(0xffFFFFFF), fontSize: 20.0),
                    )
                  ],
                ),
                const SizedBox(height: 32.0),
                Expanded(
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 10.0),
                        ListTile(
                          leading: Icon(Icons.info),
                          title: Text('Account Info'),
                        ),
                        const Divider(
                          indent: 18.0,
                          endIndent: 18.0,
                        ),
                        ListTile(
                          leading: Icon(Icons.info),
                          title: Text('My Ads'),
                        ),
                        const Divider(
                          indent: 18.0,
                          endIndent: 18.0,
                        ),
                        ListTile(
                          leading: Icon(Icons.info),
                          title: Text('Setting'),
                        ),
                        const Divider(
                          indent: 18.0,
                          endIndent: 18.0,
                        ),
                        ListTile(
                          leading: Icon(Icons.info),
                          title: Text('Help & Support'),
                        ),
                        const Divider(
                          indent: 18.0,
                          endIndent: 18.0,
                        ),
                        ListTile(
                          leading: Icon(Icons.info),
                          title: Text('About Us'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePic(context) {
    return Container(
      margin: const EdgeInsets.only(top: 25.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        shape: BoxShape.circle,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: Image.asset(
              'assets/images/profile_img.png',
              height: 108.0,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
