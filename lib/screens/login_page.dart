import 'package:chat_app/Widget/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2B475E),
      body: ListView(
        children: [
          Image.asset('assets/images/scholar.png'),
          const Text(
            'School Chat',
            style: TextStyle(
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Pacifico',
            ),
          ),
          const Text(
            'LOGIN',
            style: TextStyle(
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Pacifico',
            ),
          ),
           CustomTextField(
            hint: "Email",
          ),
           CustomTextField(
            hint: "Password",
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            color: Colors.white,
            ),
            width: double.infinity,
            height: 60,
            child: const Text(
              'LOGIN?',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,

              ),
            ),
          )
        ],
      ),
    );
  }

}
