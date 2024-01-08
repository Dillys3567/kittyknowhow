import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:kittyknowhow/components/post_card.dart';
import 'package:kittyknowhow/functions%20and%20apis/posts_api.dart';
import 'package:kittyknowhow/models/post_viewmodel.dart';
import 'package:kittyknowhow/screens/comment/comment_page.dart';
import 'package:kittyknowhow/utils/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List posts = [];
  PostsApiService postsApiService = PostsApiService();

  loadPosts() async {
    var loadPosts = await postsApiService.getPosts();
    try {
      setState(() {
        posts = loadPosts;
        print(posts);
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  void initState() {
    super.initState();
    loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(-2507562),
          title: Text(
            'KittyKnowhow',
            style: homeHeadingText,
          ),
        ),
        backgroundColor: Color(-2507562),
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              loadPosts();
            });
          },
          child: (posts.isEmpty)
              ? Center(child: Lottie.asset('assets/animations/cat.json'))
              : ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return PostCard(
                      isCommentScreen: false,
                      ownerName: posts[index].userName,
                      title: posts[index].title,
                      body: posts[index].body ?? '',
                      comments: posts[index].comment ?? 0,
                      image: posts[index].image,
                      hasImage: (posts[index].image == '') ? false : true,
                      buttonDisabled: false,
                      commentWidget: CommentPage(
                        userName: posts[index].userName,
                        title: posts[index].title,
                        image: posts[index].image,
                        body: posts[index].body ?? '',
                        comments: posts[index].comment ?? 0,
                        postId: posts[index].id,
                      ),
                    );
                  }),
        ));
  }
}
