import 'package:flutter/material.dart';
import 'package:kittyknowhow/utils/constants.dart';

class PostCreatePage extends StatefulWidget {
  const PostCreatePage({super.key});

  @override
  State<PostCreatePage> createState() => _PostCreatePageState();
}

class _PostCreatePageState extends State<PostCreatePage> {
  final _formKey = GlobalKey<FormState>();
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    // Request focus when the page is loaded
    Future.delayed(Duration.zero, () {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Icon(
          Icons.image,
          color: Color(-6656375),
          size: 35,
          shadows: [
            Shadow(color: Colors.black38, offset: Offset(5, 5), blurRadius: 50)
          ],
        )
      ],
      persistentFooterAlignment: AlignmentDirectional.bottomStart,
      floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Color(-6656375),
          onPressed: () {},
          child: Text(
            'Post',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'IndieFlower',
                fontWeight: FontWeight.w900,
                fontSize: 20),
          )),
      backgroundColor: Color(-2507562),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.cancel_outlined,
                      color: Color(-6656375),
                      size: 35,
                    ),
                  ],
                ),
                Form(
                    child: Column(
                  children: [
                    TextFormField(
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                          hintText: 'Title',
                          hintStyle: signupButtonText,
                          border: InputBorder.none),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Body text(optional)',
                          hintStyle: signupButtonText,
                          border: InputBorder.none),
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
