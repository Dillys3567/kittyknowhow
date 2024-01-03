import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kittyknowhow/functions%20and%20apis/posts_api.dart';
import 'package:kittyknowhow/models/post.dart';
import 'package:kittyknowhow/models/post_viewmodel.dart';
import 'package:kittyknowhow/screens/home/home_container.dart';
import 'package:kittyknowhow/screens/home/home_page.dart';
import 'package:kittyknowhow/utils/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PostCreatePage extends StatefulWidget {
  const PostCreatePage({super.key});

  @override
  State<PostCreatePage> createState() => _PostCreatePageState();
}

class _PostCreatePageState extends State<PostCreatePage> {
  final _formKey = GlobalKey<FormState>();
  late FocusNode _focusNode;
  late XFile? chosenImageXFile;
  late String? imageUrl;
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();

  createNewPost() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) return;

    PostsApiService postsApiService = PostsApiService();
    PostViewModel postViewModel =
        PostViewModel(postsApiService: postsApiService);
    if (chosenImageXFile != null) {
      imageUrl = await upload(chosenImageXFile);
    }
    Post post = Post(
        user_id: supabase.auth.currentUser!.id,
        title: title.text,
        body: body.text,
        image: imageUrl);

    try {
      await postsApiService.createPost(
          supabase.auth.currentUser!.id, title.text, body.text, imageUrl);
      context.showSnackBar(message: 'Post created!');
      _formKey.currentState!.reset();
      Navigator.pop(context);
    } catch (e) {
      context.showSnackBar(message: "Error creating post. Try again later.");
    }
  }

  Future<String> upload(XFile? imageFile) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Lottie.asset('assets/animations/cat.json'),
          );
        });
    try {
      final bytes = await imageFile!.readAsBytes();
      final fileExt = imageFile.path.split('.').last;
      final fileName = '${DateTime.now().toIso8601String()}.$fileExt';
      final filePath = fileName;
      await supabase.storage.from('avatars').uploadBinary(
            filePath,
            bytes,
            fileOptions: FileOptions(contentType: imageFile.mimeType),
          );
      final imageUrlResponse = await supabase.storage
          .from('avatars')
          .createSignedUrl(filePath, 60 * 60 * 24 * 365 * 10);
      return imageUrlResponse;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 400,
      maxHeight: 400,
    );
    chosenImageXFile = imageFile;
  }

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
        IconButton(
            onPressed: () => pickImage(),
            icon: Icon(
              Icons.image,
              color: Color(-6656375),
              size: 35,
              shadows: [
                Shadow(
                    color: Colors.black38, offset: Offset(5, 5), blurRadius: 50)
              ],
            )),
      ],
      persistentFooterAlignment: AlignmentDirectional.bottomStart,
      floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Color(-6656375),
          onPressed: () => createNewPost(),
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
            child: Center(
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        style: inputText,
                        controller: title,
                        focusNode: _focusNode,
                        decoration: InputDecoration(
                          labelText: 'Title',
                          labelStyle: signupButtonText,
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value!.isEmpty || value == null) {
                            return 'Please enter a title';
                          } else if (value.length > 150) {
                            return 'Title is too long';
                          } else {
                            return null;
                          }
                        },
                      ),
                      TextFormField(
                        style: inputText,
                        maxLines: null,
                        controller: body,
                        decoration: InputDecoration(
                            labelText: 'Body text(optional)',
                            labelStyle: signupButtonText,
                            border: InputBorder.none),
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
