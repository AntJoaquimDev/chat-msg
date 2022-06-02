import 'package:chat/page/auth_page.dart';
import 'package:chat/page/loading_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ant-Joaquim',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthPage(), //LoadingPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
