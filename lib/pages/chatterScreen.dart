import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cikan/model/message.dart';

class ChatterScreen extends StatefulWidget {
  final String conversationId;
  final String interlocutorName;

  ChatterScreen({Key? key, required this.conversationId, required this.interlocutorName}) : super(key: key);

  @override
  _ChatterScreenState createState() => _ChatterScreenState();
}

class _ChatterScreenState extends State<ChatterScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.interlocutorName),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('messages')
                  .where('conversationId', isEqualTo: widget.conversationId)
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                var messages = snapshot.data!.docs.map((doc) {
                  var data = doc.data() as Map<String, dynamic>;
                  return Message.fromJson(data);
                }).toList();

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final currentUser = auth.FirebaseAuth.instance.currentUser!.uid;
                    final isCurrentUser = message.senderId == currentUser;

                    return Align(
                      alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          color: isCurrentUser ? Color.fromARGB(255, 159, 35, 128) : Colors.grey[400],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [
                            Text(
                              message.text,
                              style: TextStyle(
                                color: isCurrentUser ? Colors.white : Colors.black,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              isCurrentUser ? 'Vous' : widget.interlocutorName,
                              style: TextStyle(
                                color: isCurrentUser ? Colors.white70 : Colors.black54,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() async {
    if (_messageController.text.isEmpty) {
      return;
    }

    var message = {
      'text': _messageController.text,
      'conversationId': widget.conversationId,
      'senderId': auth.FirebaseAuth.instance.currentUser!.uid,
      'timestamp': FieldValue.serverTimestamp(),
    };

    await FirebaseFirestore.instance.collection('messages').add(message);

    await FirebaseFirestore.instance.collection('conversations').doc(widget.conversationId).update({
      'lastMessage': _messageController.text,
      'lastMessageTimestamp': FieldValue.serverTimestamp(),
    });

    _messageController.clear();

    Future.delayed(Duration(seconds: 1), () {
      _sendBotResponse();
    });
  }

  void _sendBotResponse() async {
    var botMessage = {
      'text': 'Ceci est une réponse automatique du bot.',
      'conversationId': widget.conversationId,
      'senderId': 'BOT_USER_ID',
      'timestamp': FieldValue.serverTimestamp(),
    };

    await FirebaseFirestore.instance.collection('messages').add(botMessage);

    await FirebaseFirestore.instance.collection('conversations').doc(widget.conversationId).update({
      'lastMessage': 'Ceci est une réponse automatique du bot.',
      'lastMessageTimestamp': FieldValue.serverTimestamp(),
    });
  }
}


class MessageBubble extends StatelessWidget {
  final String msgText;
  final String msgSender;
  final bool user;
  MessageBubble({required this.msgText, required this.msgSender, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: user ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: user ? Color.fromARGB(255, 159, 35, 128) : Colors.black,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.all(12),
            child: Text(
              msgText,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
