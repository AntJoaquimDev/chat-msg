import 'package:chat/core/services/notification/chat_notifaction_service.dart';
import 'package:chat/page/auth_or_app_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChatNotificationService(),
        ),
      ],
      child: MaterialApp(
        title: 'Ant-Joaquim',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AuthOrAppPage(), //LoadingPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
