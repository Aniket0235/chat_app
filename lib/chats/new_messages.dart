import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class NewMessages extends StatefulWidget {
  const NewMessages({Key? key}) : super(key: key);

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  final _controller =TextEditingController();
  var _enteredMessage = '';

  void _sendMessage()async{
    FocusScope.of(context).unfocus();
    final user =FirebaseAuth.instance.currentUser;
    final userData =await FirebaseFirestore.instance.collection('Uid').doc(user!.uid).get();
    FirebaseFirestore.instance.collection("Chats/CG0swcWYwjN13Vh4UM7q/messages").add({
      'text':_enteredMessage,
      'createdAt':Timestamp.now() ,
      'userId':user.uid,
      'userImage':userData['imageUrl']
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
                controller: _controller,
            decoration: const InputDecoration(labelText: "Send a message....."),
            onChanged: (value) {
              setState(() {
                _enteredMessage = value;
              });
            },
          )),
          IconButton(
              color: Theme.of(context).primaryColor,
              onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
              icon: const Icon(Icons.send))
        ],
      ),
    );
  }
}
