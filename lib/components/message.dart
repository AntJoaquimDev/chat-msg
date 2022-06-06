import 'package:chat/components/message_bubble.dart';
import 'package:chat/core/model/chat_message.dart';
import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  const Message({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthServices().currentUser;
    return StreamBuilder<List<ChatMessage>>(
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: const CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text("Sem messagems.. Vamos conversar"),
          );
        } else {
          final msgs = snapshot.data!;
          return ListView.builder(
            reverse: true,
            itemCount: msgs.length,
            itemBuilder: (ctx, i) => MessageBubble(
              key: ValueKey(msgs[i].id),
              message: msgs[i],
              belongsToCurrentUser: currentUser?.id == msgs[i].userId,
            ),
          );
        }
      }),
      stream: ChatService().messagesStreamGet(),
    );
  }
}
