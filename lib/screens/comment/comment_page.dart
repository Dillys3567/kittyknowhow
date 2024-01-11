import 'package:flutter/material.dart';
import 'package:kittyknowhow/components/post_card.dart';
import 'package:kittyknowhow/functions_and_apis/comments_apis.dart';
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
      final response = await commentsApiService.getPostComments(widget.postId);
      print(response);
      setState(() {
        comments = response;
      });
    } catch (e) {}
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
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: comments.length,
                    itemBuilder: (content, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 8, 3),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          tileColor: Colors.white54,
                          title: Text(
                            comments[index].text,
                            style: postText,
                          ),
                          subtitle: Text('By ${comments[index].userName}'),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 68,
              )
            ],
          ),
          (supabase.auth.currentSession == null)
              ? Container()
              : Align(
                  alignment: Alignment.bottomCenter,
                  child: Form(
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
                              ? SizedBox(
                                  height: 1,
                                  width: 1,
                                  child: Center(
                                      child: CircularProgressIndicator()))
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
                      )),
                )
        ],
      ),
    );
  }
}
