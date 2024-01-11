class Comment {
  String id;
  String userId;
  String text;
  String postId;
  String userName;

  Comment({
    required this.id,
    required this.userId,
    required this.postId,
    required this.text,
    required this.userName,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        id: json['id'],
        userId: json['userId'],
        postId: json['postId'],
        text: json['text'],
        userName: json['userName']);
  }
}

// Make sure refresh indicator acts as intended on home page
