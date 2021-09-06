import 'package:get/get.dart';
import 'package:sell_begin/services/chat_service.dart';

import 'chat_controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ChatService());
    Get.put(ChatController());
  }
}
