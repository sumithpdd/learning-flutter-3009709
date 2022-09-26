// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:chat_app/models/chat_message_entity.dart';
import 'package:chat_app/widgets/chat_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widgets/chat_buddle.dart';

class ChatPage extends StatefulWidget {
  final String userName;
  ChatPage({Key? key, required this.userName}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatMessageEntity> _messages = [
    ChatMessageEntity(
        author: Author(userName: 'sumith'),
        createdAt: 2131231242,
        id: '1',
        text: "Hi , this is your message",
        imageUrl:
            'https://cdn.pixabay.com/photo/2019/09/07/02/56/background-4457839_960_720.png'),
    ChatMessageEntity(
        author: Author(userName: 'sumith'),
        createdAt: 2131231442,
        id: '1',
        text: 'Second text',
        imageUrl: 'https://3009709.youcanlearnit.net/Alien_LIL_131338.png'),
    ChatMessageEntity(
      author: Author(userName: 'jane'),
      createdAt: 2131234242,
      id: '1',
      text: 'Third text',
    )
  ];

  _loadInitialMessages() async {
    final response = await rootBundle.loadString('assets/mock_messages.json');
    final List<dynamic> decodedList = jsonDecode(response) as List;
    final List<ChatMessageEntity> _chatMessages = decodedList.map((listItem) {
      return ChatMessageEntity.fromJson(listItem);
    }).toList();
    setState(() {
      _messages = _chatMessages;
    });
  }

  onMessageSent(ChatMessageEntity entity) {
    _messages.add(entity);
    setState(() {});
  }

  @override
  void initState() {
    _loadInitialMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Hi ${widget.userName}"),
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
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return ChatBubble(
                        alignment: _messages[index].author.userName == 'sumith'
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        entity: _messages[index]);
                  })),

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

          ChatInput(
            onSubmit: onMessageSent,
          ),
        ],
      ),
    );
  }
}
