class Post {
  String? id;
  String user_id;
  String title;
  String? body;
  String? image;
  String? userName;
  int? comment;

  Post(
      {this.id,
      required this.user_id,
      required this.title,
      this.image,
      this.body,
      this.userName,
      this.comment});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        user_id: json['user_id'],
        title: json['title'],
        comment: json['comment'] ?? 0,
        body: json['body'] ?? '',
        image: json['image'] ?? '',
        userName: json['userName'] ?? '');
  }
}
