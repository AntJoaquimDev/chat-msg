import 'package:chat/core/model/chat-user.dart';
import 'package:chat/core/model/chat_message.dart';
import 'package:chat/core/services/chat/chat_firebase_service.dart';

abstract class ChatService {
  Stream<List<ChatMessage>> messagesStreamGet();
  Future<ChatMessage?> save(String text, ChatUser user);

  factory ChatService() {
    return ChatMessageService();
  }
}
