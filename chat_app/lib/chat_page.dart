// ignore_for_file: prefer_const_constructors

import 'package:chat_app/widgets/chat_input.dart';
import 'package:flutter/material.dart';

import 'widgets/chat_buddle.dart';

class ChatPage extends StatelessWidget {
  final String userName;
  const ChatPage({Key? key, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Hi $userName"),
        actions: [
          IconButton(
              onPressed: () {
                // Navigator.maybePop(context);
                Navigator.popAndPushNamed(context, '/');
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            itemCount: 10,
            itemBuilder: ((context, index) {
              return ChatBubble(
                alignment: index % 2 == 0
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                message: "Hi , this is your message",
              );
            }),
          )
              // ListView(
              //   children: [
              //     ChatBubble(
              //       alignment: Alignment.centerLeft,
              //       message: "Hi , this is your message",
              //     ),
              //     ChatBubble(
              //       alignment: Alignment.centerRight,
              //       message: "Welcome !",
              //     ),
              //   ],
              // ),
              ),
          ChatInput(),
        ],
      ),
    );
  }
}
