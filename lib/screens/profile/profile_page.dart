import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kittyknowhow/components/form_input_field.dart';
import 'package:kittyknowhow/components/pet_card.dart';
import 'package:kittyknowhow/components/post_card.dart';
import 'package:kittyknowhow/functions_and_apis/pet.dart';
import 'package:kittyknowhow/functions_and_apis/posts_api.dart';
import 'package:kittyknowhow/models/pet.dart';
import 'package:kittyknowhow/screens/comment/comment_page.dart';
import 'package:kittyknowhow/screens/settings/settings_page.dart';
import 'package:kittyknowhow/utils/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late TabController tabController;
  TextEditingController petBio = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String userName = "";
  String currentPetId = "";
  List<Pet> pets = [];
  List posts = [];
  PostsApiService postsApiService = PostsApiService();

  //gets user profile information
  getProfileInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String name = await sharedPreferences.getString('name') ?? "";
    setState(() {
      userName = name;
    });
  }

  //gets info for pets of a user
  getPetInfo() async {
    getPets();
    List<Pet> petList = await getPets();
    setState(() {
      pets = petList;
    });
  }

  //updates pet information
  updatePetProfile(String bio, String petId) async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    Navigator.pop(context);
    bool loading = true;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Lottie.asset('assets/animations/cat.json'),
          );
        });
    print(await updatePetBio(bio, petId));
    setState(() {
      getPetInfo();
    });
    Navigator.pop(context);
  }

  //allow user to enter pet information
  editPetInfo(String petId) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () => updatePetProfile(petBio.text, petId),
                  child: Text('Submit')),
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel')),
            ],
            title: Text(
              'Edit Pet Info',
              style: signupButtonText,
            ),
            content: SizedBox(
              height: 100,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FormInputField(
                      label: 'Pet Bio',
                      controller: petBio,
                      keyboardType: TextInputType.text,
                      showIcon: false,
                      validator: (val) {
                        if (val!.isEmpty || val == null)
                          return 'Cannot be empty';
                        if (val!.length > 100) {
                          return 'Not more than 100 characters';
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  //upload image for bet bio
  Future<void> upload(String petId) async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 400,
      maxHeight: 400,
    );
    if (imageFile == null) {
      return;
    }
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Lottie.asset('assets/animations/cat.json'),
          );
        });
    try {
      final bytes = await imageFile.readAsBytes();
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
      onUpload(imageUrlResponse, petId);
    } on StorageException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Unexpected error occurred'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      Navigator.pop(context);
    }
  }

  Future<void> onUpload(String imageUrl, String petId) async {
    try {
      await supabase.from('pet').update({'image': imageUrl}).eq('id', petId);
      context.showSnackBar(message: 'Image updated');
      setState(() {
        getPetInfo();
      });
    } on PostgrestException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (error) {
      context.showErrorSnackBar(message: 'Unexpected error');
    }
  }

  //get posts for particular user
  Future getMyPosts() async {
    try {
      var response =
          await postsApiService.getMyPosts(supabase.auth.currentUser!.id);
      setState(() {
        posts = response;
      });
    } catch (e) {
      context.showErrorSnackBar(message: 'Could not load posts');
    }
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    getProfileInfo();
    getPetInfo();
    getMyPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          SliverAppBar(
            backgroundColor: Color(-6656375),
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.fromLTRB(0, 30, 0, 60),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    elevation: 6,
                    color: Color(-6656375),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.white)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
                      child: Text(
                        userName,
                        softWrap: true,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'IndieFlower',
                            fontWeight: FontWeight.w900,
                            fontSize: 30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            centerTitle: true,
            snap: true,
            floating: true,
            pinned: true,
            expandedHeight: 160,
            bottom: TabBar(
                labelColor: Colors.white,
                indicatorColor: Colors.white,
                indicatorWeight: 8,
                unselectedLabelColor: Color(-2507562),
                labelStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: 'IndieFlower',
                    fontWeight: FontWeight.w900,
                    fontSize: 25),
                controller: tabController,
                tabs: [
                  Tab(
                    child: Text('Pets'),
                  ),
                  Tab(
                    child: Text('Posts'),
                  )
                ]),
            actions: [
              IconButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SettingsPage())),
                  icon: Icon(
                    Icons.menu_rounded,
                    color: Colors.white,
                    size: 35,
                  ))
            ],
          ),
          SliverFillRemaining(
              child: pets.isEmpty
                  ? Lottie.asset('assets/animations/cat.json')
                  : TabBarView(
                      children: [
                        SingleChildScrollView(
                            child: Column(
                                children: pets.map((e) {
                          return PetCard(
                            image: e.image ?? '',
                            petName: e.petName,
                            petBreed: e.breed,
                            petAge: e.age,
                            bio: e.bio,
                            callback: () => editPetInfo(
                              e.petId ?? "",
                            ),
                            pictureCallback: () => upload(e.petId ?? ""),
                          );
                        }).toList())),
                        (posts.isEmpty)
                            ? Center(
                                child:
                                    Lottie.asset('assets/animations/cat.json'))
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
                                    hasImage: (posts[index].image == '')
                                        ? false
                                        : true,
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
                      ],
                      controller: tabController,
                    ))
        ],
      ),
    );
  }
}
