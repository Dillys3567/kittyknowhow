import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kittyknowhow/screens/home/home_page.dart';
import 'package:kittyknowhow/screens/profile/profile_page.dart';
import 'package:kittyknowhow/screens/post/post_create_page.dart';
import 'package:kittyknowhow/utils/constants.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({super.key});

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  int currentIndex = 0;
  List pages = [HomePage(), PostCreatePage(), ProfilePage()];
  @override
  Widget build(BuildContext context) {
    /*
    PopScope closes app if user is signed in and goes to sign up page
    if user not signed in
     */
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (supabase.auth.currentSession == null)
          Navigator.pop(context);
        else
          SystemNavigator.pop();
      },
      child: Scaffold(
        backgroundColor: Color(-2507562),
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Color(-2507562),
          selectedLabelStyle: smallSignUpText,
          unselectedLabelStyle: smallSignUpText,
          iconSize: 26,
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.home),
                activeIcon: Icon(Icons.home_outlined)),
            BottomNavigationBarItem(
              label: 'Post',
              icon: Icon(Icons.add_comment_rounded),
              activeIcon: Icon(Icons.add_comment_outlined),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(Icons.person),
              activeIcon: Icon(Icons.person_outline),
            ),
          ],
        ),
      ),
    );
  }
}
