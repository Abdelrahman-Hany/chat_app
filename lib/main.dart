import 'package:chat_app_try/firebase_options.dart';
import 'package:chat_app_try/pages/chat_page.dart';
import 'package:chat_app_try/pages/login_page.dart';
import 'package:chat_app_try/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes:{
        LoginPage.id:(context)=>LoginPage(),
        RegisterPage.id:(context) => RegisterPage(),
        ChatPage.id:(context) => ChatPage(),
      },
      initialRoute: LoginPage.id,
    );
  }
}