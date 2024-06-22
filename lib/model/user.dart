/*class User {
  final String uid;
  final String username;
  final String avatarUrl;

  User({required this.uid, required this.username, required this.avatarUrl});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'] as String? ?? '',
      username: json['username'] as String? ?? 'Unknown',
      avatarUrl: json['avatarUrl'] as String? ?? 'https://example.com/default-avatar.png',
    );
  }
}
*/