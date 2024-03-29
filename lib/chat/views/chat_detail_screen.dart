// import 'dart:async';
// import 'dart:developer';
// import 'package:bubble/bubble.dart';
// import 'package:flutter/material.dart';
// import 'package:sell_begin/chat/chat_message.dart';
// import 'package:sell_begin/utils/display_toast_message.dart';
// import 'package:sell_begin/widgets/loading_indicator.dart';


// class ChatDetailScreen extends StatefulWidget {
//   static const String routeName = '/chat-detail';

//   final String? otherUserId;
//   final String? userName;

//   ChatDetailScreen({this.otherUserId, this.userName});

//   @override
//   _ChatDetailScreenState createState() => _ChatDetailScreenState();
// }

// class _ChatDetailScreenState extends State<ChatDetailScreen> {
//   TextEditingController msg = TextEditingController();

//   var isSending = false;
//   final ScrollController _scrollController = ScrollController();

//   List<ChatMessage> _messageList = [];
//   Timer? reloadTimer;
//   bool _isLoading = true;

//   loadMessages() async {
//     List<ChatMessage> lul = await context.read(chatProvider).getChatMessages(
//           context.read(authProvider).user['key'],
//           widget.otherUserId,
//         );
//     if (!isSending) {
//       if (mounted) {
//         setState(() {
//           // TODO
//           print("Chat Refreshed");
//           _messageList = lul.toList();
//           _isLoading = false;
//         });
//       }
//     }
//   }

//   void _onNewMessage() {
//     if (_scrollController.hasClients) {
//       _scrollController.animateTo(
//         _scrollController.position.minScrollExtent,
//         duration: Duration(milliseconds: 300),
//         curve: Curves.fastOutSlowIn,
//       );
//     }
//   }

//   @override
//   void initState() {
//     reloadTimer = new Timer.periodic(
//       Duration(seconds: 4),
//       (Timer timer) {
//         loadMessages();
//       },
//     );
//     loadMessages();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () => Navigator.of(context).pop(),
//           icon: Icon(Icons.arrow_back_ios),
//         ),
//         title: Text('${widget.userName}'),
//         centerTitle: true,
//       ),
//       body: Consumer(
//         builder: (context, watch, _) {
//           final chatPvd = watch(chatProvider);
//           final xApiKey = watch(authProvider).user['key'];
//           final me = watch(authProvider).user['user_id'];

//           return Column(
//             children: [
//               Expanded(
//                 child: _isLoading
//                     ? LoadingIndicator()
//                     : _messageList.length > 0
//                         ? ListView.builder(
//                             reverse: true,
//                             controller: _scrollController,
//                             itemCount: _messageList.length,
//                             shrinkWrap: true,
//                             itemBuilder: (context, i) {
//                               return _messageList[i].from == 'User:$me'
//                                   ? _buildMyMessage(_messageList[i])
//                                   : _buildOtherMessage(_messageList[i]);
//                             },
//                           )
//                         : Center(
//                             child: Text("no_messages"),
//                           ),
//               ),
//               Container(
//                 // padding: EdgeInsets.all(12),
//                 margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
//                 decoration:
//                     BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(32)),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     SizedBox(
//                       width: 12,
//                     ),
//                     Expanded(
//                       child: TextField(
//                         controller: msg,
//                         decoration: InputDecoration(
//                           hintText: 'type_your_message',
//                           hintStyle: TextStyle(),
//                         ),
//                       ),
//                     ),
//                     InkWell(
//                       onTap: isSending
//                           ? null
//                           : () async {
//                               setState(() {
//                                 isSending = true;
//                               });
//                               if (msg.text.trim() != "") {
//                                 var customMsg = msg.text;
//                                 msg.text = "";
//                                 ChatMessage newMessage = ChatMessage(
//                                   id: '-1',
//                                   from: 'User:$me',
//                                   to: "User:${widget.otherUserId}",
//                                   message: customMsg,
//                                   createdAt: DateTime.now(),
//                                   status: "sending",
//                                 );

//                                 var newList = _messageList;
//                                 newList.insert(0, newMessage);
//                                 setState(() {
//                                   _messageList = newList;
//                                   log('$_messageList');
//                                   _onNewMessage();
//                                 });

//                                 await chatPvd.sendMessage(
//                                   widget.otherUserId,
//                                   customMsg,
//                                   xApiKey,
//                                 );

//                                 Future.delayed(Duration(milliseconds: 500), () {
//                                   loadMessages();
//                                   setState(() {
//                                     _onNewMessage();
//                                   });
//                                 });
//                               } else {
//                                 displayToastMessage('enter_message');
//                               }
//                               setState(() {
//                                 isSending = false;
//                               });
//                             },
//                       child: Container(
//                         padding: EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Theme.of(context).primaryColor,
//                         ),
//                         child: Icon(
//                           Icons.send,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildMyMessage(ChatMessage msg) {
//     return msg.status != 'sending'
//         ? Padding(
//             key: UniqueKey(),
//             padding: const EdgeInsets.all(8.0),
//             child: Bubble(
//               margin: BubbleEdges.only(top: 10),
//               radius: Radius.zero,
//               alignment: Alignment.topRight,
//               nipWidth: 8,
//               nipHeight: 24,
//               nip: BubbleNip.rightTop,
//               color: Color.fromRGBO(170, 214, 255, 1.0),
//               child: Text('${msg.message}', textAlign: TextAlign.right),
//             ),
//           )
//         : Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Bubble(
//               margin: BubbleEdges.only(top: 10),
//               radius: Radius.zero,
//               alignment: Alignment.topRight,
//               nipWidth: 8,
//               nipHeight: 24,
//               nip: BubbleNip.rightTop,
//               color: Colors.grey[400],
//               child: Text('${msg.message}', textAlign: TextAlign.right),
//             ),
//           );
//   }

//   Widget _buildOtherMessage(ChatMessage msg) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Bubble(
//         margin: BubbleEdges.only(top: 10),
//         radius: Radius.zero,
//         alignment: Alignment.topLeft,
//         nipWidth: 8,
//         nipHeight: 24,
//         nip: BubbleNip.leftTop,
//         // color: Color.fromRGBO(225, 255, 199, 1.0),
//         color: Colors.white,
//         child: Text('${msg.message}', textAlign: TextAlign.right),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     reloadTimer?.cancel();
//     print("Stop refreshing chat");
//     super.dispose();
//   }
// }
