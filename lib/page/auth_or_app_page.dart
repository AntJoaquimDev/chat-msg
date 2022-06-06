import 'package:chat/core/model/chat-user.dart';
import 'package:chat/core/services/auth/auth_mock_service.dart';
import 'package:chat/page/auth_page.dart';
import 'package:chat/page/chat_page.dart';
import 'package:chat/page/loading_page.dart';
import 'package:flutter/material.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<ChatUser?>(
        stream: AuthMockServices().userChanges,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingPage();
          } else {
            return snapshot.hasData ? ChatPage() : AuthPage();
          }
        }),
      ),
    );
  }
}
