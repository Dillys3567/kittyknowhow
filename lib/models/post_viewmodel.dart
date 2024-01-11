import 'package:flutter/material.dart';
import 'package:kittyknowhow/functions_and_apis/posts_api.dart';
import 'package:kittyknowhow/models/post.dart';

class PostViewModel extends ChangeNotifier {
  final PostsApiService postsApiService;

  PostViewModel({required this.postsApiService});

  List<Post> _posts = [];

  List<Post> get posts => _posts;

  Future addPost(Post post) async {
    _posts.add(post);
    notifyListeners();
  }

  Future getPosts() async {
    try {
      _posts = await postsApiService.getPosts();
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }
}
