// ignore_for_file: avoid_unnecessary_containers

import 'package:chat_app/chats/messages.dart';
import 'package:chat_app/chats/new_messages.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          
        ),
        body:
            //  Container(
            //  child: ElevatedButton(onPressed: (){
            //    FirebaseFirestore.instance
            //       .collection("Chats/CG0swcWYwjN13Vh4UM7q/messages")
            //      .snapshots().listen((data) {
            //        data.docs.forEach((docs) {
            //          print(docs['text']);
            //         });
            //      });
            //  }, child: Text("data")),
            // )
            Container(
          child: Column(
            children: const [Expanded(child: Messages()), NewMessages()],
          ),
        ));
  }
}
