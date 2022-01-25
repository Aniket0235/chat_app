// ignore_for_file: avoid_unnecessary_containers

import 'package:chat_app/chats/messages.dart';
import 'package:chat_app/chats/new_messages.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GradientAppBar(),
        body: Container(
          child: Column(
            children: const [Expanded(child: Messages()), NewMessages()],
          ),
        ));
  }
}

class GradientAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  GradientAppBar({Key? key})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xff4338CA);
    const secondaryColor = Color(0xff6D28D9);
    return AppBar(
      title: const Text("Chats", style: TextStyle(color: Colors.white)),
      backgroundColor: primaryColor,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor, secondaryColor],
            stops: [0.5, 1.0],
          ),
        ),
      ),
    );
  }
}
