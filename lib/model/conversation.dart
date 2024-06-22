class Conversation {
  final String id;
  final List<String> participants;
  final String lastMessage;
  final dynamic timestamp;

  Conversation({
    required this.id,
    required this.participants,
    required this.lastMessage,
    required this.timestamp,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['id'] as String,
      participants: List<String>.from(json['participants'] as List),
      lastMessage: json['lastMessage'] as String,
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'participants': participants,
      'lastMessage': lastMessage,
      'timestamp': timestamp,
    };
  }
}
