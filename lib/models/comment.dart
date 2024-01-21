//Comment object
class Comment {
  String date;
  String id;
  String userId;
  String text;
  String postId;
  String userName;

  Comment({
    required this.date,
    required this.id,
    required this.userId,
    required this.postId,
    required this.text,
    required this.userName,
  });

  //returns a new comment object from a json object
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        date: json['date'],
        id: json['id'],
        userId: json['userId'],
        postId: json['postId'],
        text: json['text'],
        userName: json['userName']);
  }
}
