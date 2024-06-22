import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cikan/pages/chatterScreen.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth.User? user = auth.FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Conversations'),
        ),
        body: Center(
          child: Text('Vous devez être connecté pour voir vos conversations.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Cikan', selectionColor: Color.fromARGB(255, 159, 35, 128)),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('conversations')
            .where('participants', arrayContains: user.uid)
            .orderBy('lastMessageTimestamp', descending: true)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Une erreur est survenue.'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Aucune conversation trouvée.'));
          }

          String? botConversationId;
          for (var doc in snapshot.data!.docs) {
            var participants = List<String>.from(doc['participants']);
            if (participants.contains('BOT_USER_ID')) {
              botConversationId = doc.id;
              break;
            }
          }

          if (botConversationId == null) {
            return Center(child: Text('Aucune conversation avec le bot trouvée.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var conversation = snapshot.data!.docs[index];
              var lastMessage = conversation['lastMessage'] ?? '';
              var interlocutorName = 'Ace';
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage('https://gravatar.com/avatar/330548bcfa1fd9c5abe3f7506c28bc4f?s=400&d=robohash&r=x'),
                ),
                title: Text(interlocutorName),
                subtitle: Text(lastMessage),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatterScreen(
                        conversationId: conversation.id,
                        interlocutorName: interlocutorName,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
