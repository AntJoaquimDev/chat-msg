import 'dart:io';

import 'package:chat/core/model/chat-user.dart';
import 'package:chat/core/services/auth/auth_mock_service.dart';

abstract class AuthServices {
  ChatUser? get currentUser;

  Stream<ChatUser?> get userChanges;
  Future<void> signup(
    String name,
    String email,
    String password,
    File? image,
  );
  Future<void> login(
    String name,
    String email,
  );

  Future<void> logout();

  factory AuthServices() {
    return AuthMockServices();
    //return AuthFiredaseServices();
  }
}
