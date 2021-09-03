import 'package:flutter/material.dart';
import 'package:sell_begin/widgets/cache_img_widget.dart';
import 'package:sell_begin/widgets/custom_app_bar.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = '/chat-overview';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: customAppBar('Chat'),
      body: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, i) {
          return ListTile(
            leading: CacheImgWidget(
              'assets/images/dummy_profile.png',
              isProfilePic: true,
            ),
            title: Text('Chugtai'),
          );
        },
      ),
    );
  }
}
