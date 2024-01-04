import 'package:flutter/material.dart';
import 'package:kittyknowhow/utils/constants.dart';

class PostCard extends StatefulWidget {
  final String owner_name;
  final String title;
  final String body;
  final String image;
  final int likes;
  final int comments;
  final bool hasImage;
  const PostCard(
      {super.key,
      required this.owner_name,
      required this.title,
      this.image = '',
      this.body = '',
      required this.likes,
      required this.comments,
      required this.hasImage});

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
                    'Posted by ${widget.owner_name}',
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
                    child: Image.asset(
                      widget.image,
                    ),
                    elevation: 6,
                  )
                : Container(),
            Text(
              widget.body,
              style: postText,
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.favorite_border_rounded)),
                Text('${widget.likes}'),
                IconButton(
                    onPressed: () {},
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
