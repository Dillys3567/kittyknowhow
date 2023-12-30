import 'package:flutter/material.dart';

class Post {
  String id;
  String user_id;
  String title;
  String image;

  Post(
      {required this.id,
      required this.user_id,
      required this.title,
      required this.image});
}
