// ignore_for_file: unnecessary_new

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:chat_app/Screens/Home_screen.dart';
import 'package:chat_app/Screens/login_page.dart';
import 'package:chat_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/widgets/image_picker.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  File? _userImageFile;
  void _pickedImage(File image) {
    _userImageFile = image;
  }

  final TextEditingController name = new TextEditingController();
  final TextEditingController emailC = new TextEditingController();
  final TextEditingController passC = new TextEditingController();
  final TextEditingController cpass = new TextEditingController();

  void signUp(String email, String password) async {
    if (_userImageFile == null) {
      Fluttertoast.showToast(msg: "Please add an image");
      return;
    }
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                postDataToFirestore(),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDataToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    userModel UserModel = userModel();
    UserModel.uid = user!.uid;
    UserModel.email = user.email;
    UserModel.fullname = name.text;
    

    final ref = FirebaseStorage.instance.ref().child('user_image').child(user.uid + '.jpg');
    // final url = await ref.getDownloadURL();
    ref.putFile( _userImageFile!).whenComplete(() async{
      final url = await ref.getDownloadURL();
      await firebaseFirestore
        .collection("Uid")
        .doc(user.uid)
        .set({
          'uid':user.uid,
          'email':user.email,
          'fullname':name.text,
          'imageUrl':url,
        });
    });
    

        
        // .set(UserModel.tomap());
    Fluttertoast.showToast(msg: "Account created successfully !!");
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final nameField = TextFormField(
        autofocus: false,
        controller: name,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Fullname cannot be empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Name");
          }
        },
        onSaved: (value) {
          name.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          hintText: "Full Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final mailField = TextFormField(
        autofocus: false,
        controller: emailC,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Email");
          }
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          emailC.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final passField = TextFormField(
        autofocus: false,
        controller: passC,
        obscureText: true,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Fullname cannot be empty");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Name");
          }
        },
        onSaved: (value) {
          passC.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key_outlined),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final confirmPassField = TextFormField(
        autofocus: false,
        controller: cpass,
        obscureText: true,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (cpass.text != passC.text) {
            return "Password is not matching";
          }
          return null;
        },
        onSaved: (value) {
          cpass.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          hintText: "Confirm Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
            child: Container(
                color: Colors.white,
                child: Padding(
                    padding: const EdgeInsets.all(36.0),
                    child: Form(
                        key: _formKey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              UImagePicker(_pickedImage),
                              // SizedBox(
                              //     height: 200,
                              //     child: Image.asset(
                              //       "assets/main.jpg",
                              //       fit: BoxFit.contain,
                              //     )),

                              const SizedBox(
                                height: 30,
                              ),
                              nameField,
                              const SizedBox(
                                height: 15,
                              ),
                              mailField,
                              const SizedBox(
                                height: 15,
                              ),
                              passField,
                              const SizedBox(
                                height: 15,
                              ),
                              confirmPassField,
                              const SizedBox(
                                height: 15,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 60),
                                    primary: Colors.cyan,
                                    side: const BorderSide(
                                        width: 2, color: Colors.cyan),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16))),
                                onPressed: () {
                                  signUp(emailC.text, passC.text);
                                },
                                child: const Text('Sign Up',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Already have an account? "),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginPage()));
                                    },
                                    child: const Text(
                                      "Sign In",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontSize: 16),
                                    ),
                                  )
                                ],
                              )
                            ]))))),
      ),
    );
  }
}
