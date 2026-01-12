import 'package:chat_app/Widget/constant.dart';
import 'package:flutter/material.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(

        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 16,top: 32,bottom: 32,right: 32),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          border: Border.all(color: Colors.white, width: 2),
      
          color: kPrimaryColor,
        ),
        child: Text(
          'i am a new user',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  
  }
}
