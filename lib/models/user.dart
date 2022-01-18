class userModel{
  String? uid;
  String? email;
  String? fullname;
  String? imageUrl;

  userModel({
    this.email,this.fullname,this.uid,this.imageUrl
  });

  factory userModel.fromMap(map){
     return userModel(
       uid: map['uid'],
       email: map['email'],
       fullname: map['fullname'],
       imageUrl: map['imageUrl']
     );
  }


  Map<String,dynamic> tomap(){
    return{
      'uid':uid,
      'email':email,
      'fullname':fullname,
      'imageUrl':imageUrl,
    };
  }
}
