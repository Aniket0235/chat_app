import 'package:cloud_firestore/cloud_firestore.dart';

class Databasemethods {
  getUser(String username)async{
   return await FirebaseFirestore.instance
        .collection("Uid")
        .where("fullname", isEqualTo: username)
        .get();
  }
  Future getUsers()async{
     return await FirebaseFirestore.instance.collection("Uid").get();
  }
}
