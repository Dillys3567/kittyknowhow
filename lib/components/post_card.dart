import 'package:flutter/material.dart';
import 'package:kittyknowhow/utils/constants.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostCard extends StatefulWidget {
  final String date;
  final String ownerName;
  final String title;
  final String body;
  final String image;
  final int comments;
  final bool hasImage;
  final bool buttonDisabled;
  final bool isCommentScreen;
  final bool isMyPost;
  final Widget commentWidget;
  String? postId;
  final deleteAction;
  PostCard(
      {super.key,
      required this.date,
      required this.ownerName,
      required this.title,
      required this.buttonDisabled,
      this.image = '',
      this.body = '',
      this.isMyPost = false,
      this.deleteAction,
      required this.comments,
      required this.hasImage,
      required this.isCommentScreen,
      required this.commentWidget,
      this.postId});

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Posted by ${widget.ownerName}',
                        style: postText,
                      ),
                      (widget.isMyPost)
                          ? IconButton(
                              onPressed: widget.deleteAction,
                              icon: Icon(Icons.delete))
                          : SizedBox.shrink()
                    ],
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
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
                      ),
                      Text(
                        '${timeago.format(DateTime.parse(widget.date), locale: 'en_short')}',
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
