import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sell_begin/auth/user.dart';
import 'package:sell_begin/chat/chat.dart';

import 'package:http/http.dart' as http;
import 'package:sell_begin/services/chat_service.dart';

class ChatController extends GetxController {
  final _chatService = Get.find<ChatService>();

  Future<List<Chat>> getConversation() async {
    return (await _chatService.getConversation() as List).map((i) => Chat.fromJson(i)).toList();
  }

}
