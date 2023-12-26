import 'package:flutter/material.dart';
import 'package:kittyknowhow/screens/settings/settings_page.dart';
import 'package:kittyknowhow/screens/signup_signin/signup_signin.dart';
import 'package:kittyknowhow/utils/constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(-2507562),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingsPage())),
                        icon: Icon(
                          Icons.menu_rounded,
                          color: Color(-6656375),
                          size: 35,
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
