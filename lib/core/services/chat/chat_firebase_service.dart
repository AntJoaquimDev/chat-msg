import 'dart:async';
import 'dart:math';

import 'package:chat/components/new_message.dart';
import 'package:chat/core/model/chat_message.dart';
import 'package:chat/core/model/chat-user.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChatMessageService implements ChatService {
  @override
  Stream<List<ChatMessage>> messagesStreamGet() {
    final store = FirebaseFirestore.instance;
    final snapshots = store
        .collection('chat')
        .withConverter(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        )
        .orderBy('createdAt', descending: true)
        .snapshots();
    return snapshots.map((snapshot) => snapshot.docs.map((doc) {
          return doc.data();
        }).toList());

    //outra forma de retornar a lista de chat
    // return Stream<List<ChatMessage>>.multi((controller) {
    //   snapshots.listen((snapshot) {
    //     List<ChatMessage> lista = snapshot.docs.map((doc) {
    //       return doc.data();
    //     }).toList();
    //     controller.add(lista);
    //   });
    // });
  }

  Future<ChatMessage?> save(String text, ChatUser user) async {
    final store = FirebaseFirestore.instance;

    final msg = ChatMessage(
      id: user.id,
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageUrl: user.imageUrl,
    );
    //chatMessage para tipo string e dynamic
    final docRefChat = await store
        .collection('chat')
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .add(msg);

    final doc = await docRefChat.get();
    return doc.data()!;
  }

  Map<String, dynamic> _toFirestore(
    ChatMessage msg,
    SetOptions? options,
  ) {
    return {
      'text': msg.text,
      'createdAt': msg.createdAt.toIso8601String(),
      'userId': msg.id,
      'userName': msg.userName,
      'userImageUrl': msg.userImageUrl,
    };
  }

  ChatMessage _fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> doc, SnapshotOptions? options) {
    return ChatMessage(
      id: doc.id,
      text: doc['text'],
      createdAt: DateTime.parse(doc['createdAt']),
      userId: doc['userId'],
      userName: doc['userName'],
      userImageUrl: doc['userImageUrl'],
    );
  }
}
