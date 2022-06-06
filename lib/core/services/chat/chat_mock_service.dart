import 'dart:async';
import 'dart:math';

import 'package:chat/components/new_message.dart';
import 'package:chat/core/model/chat_message.dart';
import 'package:chat/core/model/chat-user.dart';
import 'package:chat/core/services/chat/chat_service.dart';

class ChatMockService implements ChatService {
  static final List<ChatMessage> _msgs = [];
  static MultiStreamController<List<ChatMessage>>? _controllerMsg;
  //minha Stream de message.
  static final _msgStream = Stream<List<ChatMessage>>.multi((controllerMsg) {
    _controllerMsg = controllerMsg;
    controllerMsg.add(_msgs);
  });
  @override
  Stream<List<ChatMessage>> messagesStreamGet() {
    return _msgStream;
  }

  @override
  Future<ChatMessage> save(String text, ChatUser user) async {
    final newMessage = ChatMessage(
      id: Random().nextDouble().toString(),
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageUrl: user.imageUrl,
    );
    _msgs.add(newMessage);
    _controllerMsg?.add(_msgs.reversed.toList());
    return newMessage;
  }
}
