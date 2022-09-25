// ignore_for_file: prefer_const_constructors

import 'package:chat_app/chat_page.dart';
import 'package:chat_app/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chat App",
      theme: ThemeData(
        primarySwatch: Colors.purple,
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.blue, foregroundColor: Colors.black),
      ),
      home: LoginPage(),
      routes: {'/chat': (context) => ChatPage(userName: 'userName')},
    );
  }
}
