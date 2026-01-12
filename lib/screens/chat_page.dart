import 'package:chat_app/Widget/chat_buble.dart';
import 'package:chat_app/Widget/constant.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  static String id = 'chat_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(kLogo, height: 40),
            const SizedBox(width: 10),
            const Text(
              'Chat',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ],
        ),
      ),
      body: Column(
        children:[
           Expanded(
             child: ListView.builder(
                       itemCount: 10,
                       itemBuilder: (context, index) {
              return ChatBuble();
                       },
                     ),
           ),
           Padding(
            padding:   
             const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
             child: TextField(
              
               decoration: InputDecoration(
                hintText: 'Write your message here...',
                suffixIcon: Icon(
                  Icons.send,
                  color: kPrimaryColor,
                  ),
                 border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                 ),
                 labelText: 'Type your message',
               ),
             ),
           ),
      ]),
    );
  }
}
