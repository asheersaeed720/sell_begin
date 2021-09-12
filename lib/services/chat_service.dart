import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sell_begin/chat/chat.dart';

class ChatService extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://s-p.restncode.com/API/';
    super.onInit();
  }

  Future<List<Chat>> getConversation() async {
    var res = await get('Chat/chats',
        contentType: 'form-data', headers: {'x-api-key': '${getKey()}'});
    List<Chat> a = (res.body as List).map((e) => Chat.fromJson(e)).toList();
    return a;
  }

  Future<List<Chat>> getChats(id) async {
    var res = await get('Chat/messages?otherUser=$id',
        contentType: 'form-data', headers: {'x-api-key': '${getKey()}'});
    List<Chat> a = (res.body as List).map((e) => Chat.fromJson(e)).toList();
    return a;
  }

  Future<bool> sendMessage(otherUser,msg) async {
    var res = await post("Chat/message",FormData( {"to": "$otherUser", "message": "$msg"}),
        contentType: 'form-data', headers: {'x-api-key': '${getKey()}'},);
    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  getKey() {
    return GetStorage().read('user') == null
        ? {}
        : GetStorage().read('user')['key'];
  }
}
