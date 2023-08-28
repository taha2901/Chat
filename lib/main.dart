import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/pages/chat_page.dart';
import 'package:scholar_chat/pages/login_pages.dart';
import 'package:scholar_chat/pages/register_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginPage.id: (context) => LoginPage(),
        RegisterPage.id : (context) => RegisterPage(),
        ChatPage.id : (context) =>  ChatPage(),
      },
      title: 'Flutter Demo',
      initialRoute: LoginPage.id,
      debugShowCheckedModeBanner: false,
    );
  }
}
