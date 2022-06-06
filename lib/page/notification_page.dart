import 'dart:developer';

import 'package:chat/core/services/notification/chat_notifaction_service.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class NotificatioPage extends StatelessWidget {
  const NotificatioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final service = Provider.of<ChatNotificationService>(context);
    final Items = service.items;

    return Scaffold(
        appBar: AppBar(
          title: Text('Minhas Notifações'),
        ),
        body: ListView.builder(
            itemCount: service.itemsCount,
            itemBuilder: (ctx, i) => ListTile(
                  title: Text(Items[i].title),
                  subtitle: Text(Items[i].body),
                  onTap: () => service.remove(i),
                )));
  }
}
