import 'package:chat/core/services/auth/auth_service.dart';
import 'package:chat/core/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String _message = '';
  final _messsageController = TextEditingController();

  Future<void> _sendMessage() async {
    final user = AuthServices().currentUser;
    if (user != null) {
      await ChatService().save(_message, user);
      _messsageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _messsageController,
            onChanged: (msg) => setState(() => _message = msg),
            decoration: InputDecoration(
              labelText: 'Enviar messagem...',
            ),
            onSubmitted: (_) {
              if (_message.isNotEmpty) {
                _sendMessage();
              }
            },
          ),
        ),
        IconButton(
          icon: Icon(Icons.send),
          onPressed: _message.trim().isEmpty ? null : _sendMessage,
        ),
      ],
    );
  }
}
