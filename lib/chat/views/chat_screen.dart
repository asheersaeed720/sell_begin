import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sell_begin/chat/chat_controller.dart';
import 'package:sell_begin/widgets/cache_img_widget.dart';
import 'package:sell_begin/widgets/custom_app_bar.dart';

import '../chat.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = '/chat-overview';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _chatController = Get.find<ChatController>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar('Message'),
      body: Text('asd'),
      // body: SingleChildScrollView(
      //   child: Container(
      //     height: MediaQuery.of(context).size.height * 0.9,
      //     // padding: const EdgeInsets.all(12.0),
      //     child: FutureBuilder<List<Chat>>(
      //         future: _chatController.getConversation(),
      //         builder: (context, snapshot) {
      //           if (snapshot.hasData) {
      //             List<Chat> list = snapshot.data!;
      //             return list.length > 0
      //                 ? ListView.builder(
      //                     itemCount: list.length,
      //                     itemBuilder: (context, i) {
      //                       Chat chat=list.elementAt(i);
      //                       return Column(
      //                         children: [
      //                           InkWell(
      //                             child: ListTile(
      //                               tileColor: Colors.white,
      //                               leading: CircleAvatar(
      //                                 backgroundColor:
      //                                     Theme.of(context).primaryColor,
      //                                 backgroundImage: Image.network(
      //                                         " /assets/uploads/Customer")
      //                                     .image,
      //                               ),
      //                               title: Text(
      //                                   '${chat.from}'),
      //                               subtitle: Text(
      //                                 '${chat.message}',
      //                                 maxLines: 3,
      //                               ),
      //                               // trailing: Text(toFormate(DateTime.parse(
      //                               //     list.elementAt(i)['lastmessage']
      //                               //         ['datetime']))),
      //                             ),
      //                             onTap: () {
      //                               // Navigator.push(
      //                               //     context,
      //                               //     MaterialPageRoute(
      //                               //       builder: (context) => Chatting(
      //                               //         id: "${list.elementAt(i)['chat_id']}",
      //                               //         name:
      //                               //             "${list.elementAt(i)['customer']['Customer_name']}",
      //                               //         img:
      //                               //             "${list.elementAt(i)['customer']['Customer_profile_img']}",
      //                               //         customerId:
      //                               //             "${list.elementAt(i)['customer']['Customer_id']}",
      //                               //       ),
      //                               //     ));
      //                             },
      //                           ),
      //                           Divider(),
      //                         ],
      //                       );
      //                     },
      //                   )
      //                 : Center(child: Text("No Messages"));
      //           } else {
      //             return Center(child: CircularProgressIndicator());
      //           }
      //         }),
      //   ),
      // ),
    );
  }
}
