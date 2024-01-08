import 'package:flutter/material.dart';
import 'package:kittyknowhow/components/form_input_field.dart';
import 'package:kittyknowhow/components/post_card.dart';
import 'package:lottie/lottie.dart';
import 'package:kittyknowhow/functions and apis/comments_apis.dart';
import '../../utils/constants.dart';

class CommentPage extends StatefulWidget {
  final String title;
  final String body;
  final String image;
  final int comments;
  final String userName;
  final String postId;
  const CommentPage({
    super.key,
    required this.userName,
    required this.title,
    required this.image,
    required this.body,
    required this.comments,
    required this.postId,
  });

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  TextEditingController _comment = TextEditingController();
  CommentsApiService commentsApiService = CommentsApiService();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  List comments = [];

  List<Widget> commentCards = [];

  Future createNewComment() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    setState(() {
      _isLoading = true;
    });
    try {
      await commentsApiService.createComment(
          supabase.auth.currentUser!.id, _comment.text, widget.postId);
      _formKey.currentState!.reset();
      _comment.clear();
      context.showSnackBar(message: 'You have commented!');
      setState(() {
        _isLoading = false;
        getComments();
      });
    } catch (e) {
      context.showErrorSnackBar(message: 'Could not create comment');
    }
  }

  Future getComments() async {
    try {
      var response = await commentsApiService.getPostComments(widget.postId);
      setState(() {
        comments = response;
        print(comments);
      });
      commentCards.clear();
      comments.forEach((comment) {
        commentCards.add(Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            tileColor: Colors.white54,
            title: Text(
              comment['text'],
              style: postText,
            ),
            subtitle: Text(comment['user_id']),
          ),
        ));
      });
    } catch (e) {
      context.showErrorSnackBar(message: '${e}');
    }
  }

  @override
  void initState() {
    super.initState();
    getComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(-2507562),
      appBar: AppBar(
        backgroundColor: Color(-2507562),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    PostCard(
                      isCommentScreen: true,
                      ownerName: widget.userName,
                      title: widget.title,
                      body: widget.body,
                      image: widget.image,
                      comments: widget.comments,
                      hasImage: (widget.image.isEmpty) ? false : true,
                      buttonDisabled: true,
                      commentWidget: Container(),
                    ),
                    (comments.isEmpty)
                        ? Text(
                            'No comments yet',
                            style: signupButtonText,
                          )
                        : Column(
                            children: commentCards,
                          )
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: TextFormField(
                  validator: (val) {
                    if (val!.isEmpty || val == null)
                      return 'Submit valid comment';
                    else
                      return null;
                  },
                  controller: _comment,
                  decoration: InputDecoration(
                    suffixIcon: (_isLoading)
                        ? Icon(Icons.data_saver_off_rounded)
                        : IconButton(
                            onPressed: () => createNewComment(),
                            icon: Icon(
                              Icons.send,
                              color: Color(-6656375),
                            ),
                          ),
                    hintText: 'Add a comment',
                    hintStyle: smallSignUpText,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(-6656375), width: 1),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            topLeft: Radius.circular(25))),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(-6656375), width: 1),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            topLeft: Radius.circular(25))),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

// Card(
// color: Colors.white,
// shape: RoundedRectangleBorder(
// side: BorderSide(color: Color(-6656375), width: 1),
// borderRadius: BorderRadius.circular(15)),
// child: Padding(
// padding: const EdgeInsets.all(8.0),
// child: Column(
// children: [
// Container(
// width: double.infinity,
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// 'Posted by ${comment['user_id']}',
// style: postText,
// ),
// Text(
// comment['text'],
// style: postText,
// ),
// ],
// ),
// ),
// ],
// ),
// ),
// )
