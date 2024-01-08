import 'package:flutter/material.dart';
import 'package:kittyknowhow/screens/comment/comment_page.dart';
import 'package:kittyknowhow/utils/constants.dart';

class PostCard extends StatefulWidget {
  final String ownerName;
  final String title;
  final String body;
  final String image;
  final int comments;
  final bool hasImage;
  final bool buttonDisabled;
  final bool isCommentScreen;
  final Widget commentWidget;
  const PostCard(
      {super.key,
      required this.ownerName,
      required this.title,
      required this.buttonDisabled,
      this.image = '',
      this.body = '',
      required this.comments,
      required this.hasImage,
      required this.isCommentScreen,
      required this.commentWidget});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(-6656375), width: 1),
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Posted by ${widget.ownerName}',
                    style: postText,
                  ),
                  Text(
                    widget.title,
                    style: postTitleText,
                  ),
                ],
              ),
            ),
            (widget.hasImage)
                ? Card(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: FadeInImage.assetNetwork(
                          width: MediaQuery.of(context).size.width * 0.88,
                          height: MediaQuery.of(context).size.width * 0.88,
                          placeholder: 'assets/images/pawprint.png',
                          fit: BoxFit.fitHeight,
                          image: widget.image),
                    ),
                    elevation: 6,
                  )
                : Container(),
            (widget.body == '')
                ? Container()
                : Text(
                    widget.body,
                    style: postText,
                  ),
            (widget.isCommentScreen)
                ? Container()
                : Row(
                    children: [
                      IconButton(
                          onPressed: (widget.buttonDisabled)
                              ? null
                              : () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          widget.commentWidget)),
                          icon: Icon(Icons.messenger_outline_rounded)),
                      Text('${widget.comments}'),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
