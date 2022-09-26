// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:chat_app/models/chat_message_entity.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/widgets/chat_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'models/image_model.dart';
import 'widgets/chat_buddle.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key? key}) : super(key: key);

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

  _getNetworkImages() async {
    var endpointUrl = Uri.parse('https://pixelford.com/api2/images');

    final response = await http.get(endpointUrl);

    if (response.statusCode == 200) {
      final List<dynamic> decodedList = jsonDecode(response.body) as List;

      final List<PixelfordImage> _imageList = decodedList.map((listItem) {
        return PixelfordImage.fromJson(listItem);
      }).toList();

      print(_imageList[0].urlFullSize);
    }
  }

  @override
  void initState() {
    _loadInitialMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userName = context.watch<AuthService>().getUserName();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Hi ${userName}"),
        actions: [
          IconButton(
              onPressed: () {
                // Navigator.maybePop(context);
                context.read<AuthService>().updateUserName("Newname");
              },
              icon: Icon(Icons.update)),
          IconButton(
              onPressed: () {
                // Navigator.maybePop(context);
                context.read<AuthService>().logoutUser();
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
                        alignment: _messages[index].author.userName ==
                                context.read<AuthService>().getUserName()
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
