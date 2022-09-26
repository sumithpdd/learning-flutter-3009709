// ignore_for_file: prefer_const_constructors

import 'package:chat_app/models/chat_message_entity.dart';
import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {
  final Function(ChatMessageEntity) onSubmit;

  ChatInput({Key? key, required this.onSubmit}) : super(key: key);
  final chatMessageController = TextEditingController();
  void sendButtonPressed() {
    print(chatMessageController.value);
    final newChatMessage = ChatMessageEntity(
        text: chatMessageController.text,
        id: "1234",
        createdAt: DateTime.now().microsecondsSinceEpoch,
        author: Author(userName: "sumith"));
    onSubmit(newChatMessage);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              minLines: 1,
              controller: chatMessageController,
              textCapitalization: TextCapitalization.sentences,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  hintText: "Type your message",
                  hintStyle: TextStyle(
                    color: Colors.blueGrey,
                  ),
                  border: InputBorder.none),
            ),
          ),
          IconButton(
            onPressed: sendButtonPressed,
            icon: Icon(
              Icons.send,
              color: Colors.white,
            ),
          )
        ],
      ),
      height: 100,
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    );
  }
}
