import 'package:chat_app/Widget/constant.dart';

 class Message {
  Message(this.message, this.id);
  final String message;
  final String id;

  factory Message.fromJson(Map<String, dynamic> jsonData) {
    return Message(
      jsonData[kMessage] ?? '',
      jsonData[kUser] ?? '',
    );
  }
}
