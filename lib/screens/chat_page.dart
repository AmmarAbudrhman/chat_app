import 'package:chat_app/Widget/chat_buble.dart';
import 'package:chat_app/Widget/constant.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/models/message.dart';

class ChatPage extends StatelessWidget {
  static String id = 'chat_page';
  CollectionReference messages = FirebaseFirestore.instance.collection(
    kMessagesCollection,
  );
  final _controller = ScrollController();
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String currentUser = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(
              Message.fromJson(
                snapshot.data!.docs[i].data() as Map<String, dynamic>,
              ),
            );
          }
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
              children: [
                Expanded(
                  child: Container(
                    color: Color(0xFFF5F5F5),
                    child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return messagesList[index].id == currentUser
                            ? ChatBuble(message: messagesList[index])
                            : ChatBubleForFriend(message: messagesList[index]);
                      },
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          decoration: InputDecoration(
                            hintText: 'Type a message',
                            filled: true,
                            fillColor: Color(0xFFF0F0F0),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24.0),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24.0),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        backgroundColor: kPrimaryColor,
                        radius: 24,
                        child: IconButton(
                          onPressed: () {
                            if (messageController.text.trim().isNotEmpty) {
                              messages.add({
                                kMessage: messageController.text,
                                kCreatedAt: DateTime.now(),
                                kUser: currentUser,
                              });
                              messageController.clear();
                              _controller.animateTo(
                                0,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn,
                              );
                            }
                          },
                          icon: Icon(Icons.send, color: Colors.white, size: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
