import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String text;
  final String conversationId;
  final String senderId;
  final Timestamp timestamp;

  Message({
    required this.text,
    required this.conversationId,
    required this.senderId,
    required this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      text: json['text'] as String,
      conversationId: json['conversationId'] as String,
      senderId: json['senderId'] as String,
      timestamp: json['timestamp'] as Timestamp,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'conversationId': conversationId,
      'senderId': senderId,
      'timestamp': timestamp,
    };
  }
}
