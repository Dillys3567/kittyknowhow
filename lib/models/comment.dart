import 'package:flutter/material.dart';

class Comment {
  String id;
  String user_id;
  String title;
  String body;
  String image;

  Comment(
      {required this.id,
      required this.user_id,
      required this.title,
      required this.body,
      required this.image});
}
