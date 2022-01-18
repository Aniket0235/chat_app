import 'package:chat_app/chats/message_design.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);
//Chats/CG0swcWYwjN13Vh4UM7q/messages
  @override
  Widget build(BuildContext context) {
    final user =FirebaseAuth.instance.currentUser;
    
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Chats/CG0swcWYwjN13Vh4UM7q/messages").orderBy('createdAt',descending: true).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamsnapshot) {
        if (streamsnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      // print(streamsnapshot.data?.docs[0]['userId']);
        // final chatDocs = streamsnapshot.data!.docs;
            return ListView.builder(
              reverse: true,
              itemBuilder: (context, index) =>Design( 
                // streamsnapshot.data?.docs[index]['username'],
                // streamsnapshot.data?.docs[index]['userImage'],
                streamsnapshot.data?.docs[index]['userId'],
                streamsnapshot.data?.docs[index]['text'],
                streamsnapshot.data?.docs[index]['userId']==user?.uid,
                key: ValueKey( streamsnapshot.data?.docs[index].id),
              ),
              //  Design(streamsnapshot.data?.docs[index]['text'],streamsnapshot.data?.docs[index]['userId']),
              itemCount: streamsnapshot.data?.docs.length,
            );
      },
    );
  }
}
// Text(streamsnapshot.data?.docs[index]['text']),