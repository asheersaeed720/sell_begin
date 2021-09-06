import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ChatService extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://s-p.restncode.com/API/';
    super.onInit();
  }

  Future<Response> getConversation() {
    return get('Chat/chats',
        contentType: 'form-data', headers: {'x-api-key': '${getKey()}'});
  }

  getKey() {
    return GetStorage().read('user') == null
        ? {}
        : GetStorage().read('user')['key'];
  }
}
