class Post {
  String? id;
  String user_id;
  String title;
  String? body;
  String? image;
  int? like;

  Post(
      {this.id,
      required this.user_id,
      required this.title,
      this.image,
      this.body,
      this.like});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      user_id: json['user_id'],
      title: json['title'],
      body: json['body'] ?? '',
      image: json['image'] ?? '',
      like: json['like'],
    );
  }
}
