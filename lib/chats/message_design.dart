import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:auto_size_text/auto_size_text.dart';

class Design extends StatelessWidget {
  final String message;
  final bool isMe;
  final String userId;
  final Key key;
  const Design(this.userId, this.message, this.isMe, {required this.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: isMe ? Colors.amber[200] : Colors.grey[300],
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(12),
                    topRight: const Radius.circular(12),
                    bottomLeft: !isMe
                        ? const Radius.circular(0)
                        : const Radius.circular(12),
                    bottomRight: isMe
                        ? const Radius.circular(0)
                        : const Radius.circular(12))),
            width: 150,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Column(
              crossAxisAlignment:isMe? CrossAxisAlignment.end:CrossAxisAlignment.start,
              children: [
              FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('Uid')
                      .doc(userId)
                      .get(),
                  builder: (ctx, AsyncSnapshot futureSnapshot) {
                    if (futureSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    return 
                    Text(
                      (futureSnapshot.requireData["fullname"]),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    );
                  }),
              Text(
                message,
                style: const TextStyle(color: Colors.red),
                textAlign: isMe?TextAlign.end:TextAlign.start,
              ),
            ]),
          ),
        ]);
  }
}
