// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {
  ChatInput({Key? key}) : super(key: key);
  final chatMessageController = TextEditingController();
  void sendButtonPressed() {
    print(chatMessageController.value);
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
