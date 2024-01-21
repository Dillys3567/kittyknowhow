import 'package:flutter/material.dart';
import 'package:kittyknowhow/components/post_card.dart';
import 'package:kittyknowhow/functions_and_apis/posts_api.dart';
import 'package:kittyknowhow/screens/comment/comment_page.dart';
import 'package:kittyknowhow/utils/constants.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List posts = [];
  bool isLoading = false;
  PostsApiService postsApiService = PostsApiService();

  loadPosts() async {
    try {
      var loadPosts = await postsApiService.getPosts();
      setState(() {
        posts = loadPosts;
        isLoading = false;
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
              isLoading = true;
              loadPosts();
            });
          },
          child: (posts.isEmpty || isLoading)
              ? Center(child: Lottie.asset('assets/animations/cat.json'))
              : ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return PostCard(
                      isCommentScreen: false,
                      date: posts[index].date,
                      ownerName: posts[index].userName,
                      title: posts[index].title,
                      body: posts[index].body ?? '',
                      comments: posts[index].comment ?? 0,
                      image: posts[index].image,
                      hasImage: (posts[index].image == '') ? false : true,
                      buttonDisabled: false,
                      commentWidget: CommentPage(
                        date: posts[index].date,
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
