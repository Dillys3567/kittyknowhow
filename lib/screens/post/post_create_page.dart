import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kittyknowhow/functions_and_apis/posts_api.dart';
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
  String imageUrl = '';
  bool imagePicked = false;
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  bool imageSelected = false;
  bool isLoading = false;

  createNewPost() async {
    final isValid = _formKey.currentState!.validate();
    //check if state is valid
    if (!isValid) return;
    setState(() {
      isLoading = true;
    });

    PostsApiService postsApiService = PostsApiService();

    //check if image has been picked and upload to supabase buckets
    if (imagePicked == true) {
      imageUrl = await upload(chosenImageXFile);
    }
    //upload new post
    try {
      await postsApiService.createPost(
          supabase.auth.currentUser!.id, title.text, body.text, imageUrl);
      setState(() {
        isLoading = false;
        title.clear();
        body.clear();
        imageUrl = '';
        imageSelected = false;
      });
      context.showSnackBar(message: 'Post created!');
    } catch (e) {
      context.showSnackBar(message: "Error creating post. Try again later.");
    }
  }

  //upload image using by creating file path from XFile format
  Future<String> upload(XFile? imageFile) async {
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

  //allow user to pick image from gallery
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 400,
      maxHeight: 400,
    );
    setState(() {
      chosenImageXFile = imageFile;
      imagePicked = true;
      imageSelected = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    // Request focus when the page is loaded for post title input
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
    return (isLoading)
        ? Center(
            child: Lottie.asset('assets/animations/cat.json'),
          )
        : Scaffold(
            persistentFooterButtons: [
              IconButton(
                  iconSize: 35,
                  color: Color(-6656375),
                  isSelected: imageSelected,
                  onPressed: () => pickImage(),
                  selectedIcon: Icon(
                    Icons.image_outlined,
                    color: Colors.green,
                  ),
                  icon: Icon(
                    Icons.image,
                    color: Color(-6656375),
                    shadows: [
                      Shadow(
                          color: Colors.black38,
                          offset: Offset(5, 5),
                          blurRadius: 50)
                    ],
                  )),
            ],
            persistentFooterAlignment: AlignmentDirectional.bottomStart,
            floatingActionButton: FloatingActionButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
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
                              textCapitalization: TextCapitalization.sentences,
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
                              textCapitalization: TextCapitalization.sentences,
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
