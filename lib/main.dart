import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/chatbot.dart';
import 'package:project/forgot.dart';
import 'package:project/login.dart';
import 'package:project/phoneauthen.dart';
import 'package:project/signup.dart';
// import 'login_screen.dart'; // Import the login screen

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Authentication App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/phone-auth': (context) => PhoneAuthScreen(),
        '/chatbot': (context) => ChatbotScreen(),
        '/forgot':(context)=> Forgot(),
      },
    );
  }
}
