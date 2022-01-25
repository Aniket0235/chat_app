import 'package:chat_app/Screens/home_screen.dart';
import 'package:chat_app/Screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
} 
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      
      home:StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
         if (snapshot.hasData) {
              return const HomePage();
            }
            return const LoginPage();
        },)
    );
  }
}

