// ignore_for_file: annotate_overrides

import 'dart:async';
import 'dart:math';

import 'package:chat/core/model/chat-user.dart';
import 'package:chat/core/model/chat-user.dart';
import 'dart:io';

import 'package:chat/core/services/auth/auth_service.dart';

class AuthMockServices implements AuthServices {
  static final _defaultUser = ChatUser(
    id: '1',
    name: 'luiz',
    email: 'z@gmail.com',
    imageUrl: 'assets/images/avatar.png',
  );
  //simulmdo um banco de dados usando menbros static.
  static Map<String, ChatUser> _users = {
    _defaultUser.email: _defaultUser,
  };
  static ChatUser? _currentUser;

  static MultiStreamController<ChatUser?>? _controller;

  static final _userStream = Stream<ChatUser?>.multi((controllerUser) {
    _controller = controllerUser;
    _updateUser(_defaultUser);
  });

  static void _updateUser(ChatUser? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }

  ChatUser? get currentUser => _currentUser;

  Stream<ChatUser?> get userChanges => _userStream;

  Future<void> login(String name, String email) async {
    _updateUser(_users[email]);
  }

  Future<void> logout() async {
    _updateUser(null); //para zerar user atual e gerar um novo valor
  }

  Future<void> signup(
    String name,
    String email,
    String password,
    File? image,
  ) async {
    final newUser = ChatUser(
      id: Random().nextDouble().toString(),
      name: name,
      email: email,
      imageUrl: image?.path ?? 'assets/images/avatar.png',
    );
    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }
}
