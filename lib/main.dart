import 'package:chat_app/screens/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const SchoolChat());
}

class SchoolChat extends StatelessWidget {
  const SchoolChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}