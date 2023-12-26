import 'package:flutter/material.dart';
import 'package:kittyknowhow/screens/signup_signin/signup_signin.dart';
import 'package:kittyknowhow/utils/constants.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List title = ['Sign out', 'Delete Account'];
  List icons = [Icons.logout_rounded, Icons.delete];
  List callbacks = [];

  _signOut() async {
    try {
      supabase.auth.signOut();
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return SignUpSignInPage();
      }), (route) => false);
    } catch (e) {
      context.showErrorSnackBar(
          message: 'Trouble signing out. Try again later');
    }
  }

  _deleteAccount() async {
    try {
      await supabase.rpc('delete_user');
      _signOut();
    } catch (e) {
      context.showErrorSnackBar(
          message: 'Could not delete account. Try again later');
    }
  }

  @override
  Widget build(BuildContext context) {
    callbacks = [_signOut, _deleteAccount];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: appBarText,
        ),
        backgroundColor: Color(-6656375),
        iconTheme: IconThemeData(color: Color(-1514516)),
      ),
      backgroundColor: Color(-1514516),
      body: SafeArea(
          minimum: EdgeInsets.fromLTRB(15, 20, 15, 0),
          child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                        title: Text(
                          title[index],
                          style: smallSignUpText,
                        ),
                        trailing: Icon(
                          icons[index],
                          color: Color(-6656375),
                        ),
                        onTap: () => showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  title[index],
                                  style: smallSignUpText,
                                ),
                                content: Text(
                                  "Do you wish to ${title[index]}?",
                                  style: smallSignUpText,
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: callbacks[index],
                                      child: Text('Yes')),
                                  TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text('No'))
                                ],
                              );
                            })),
                    Divider(
                      color: Color(-6656375),
                      height: 20,
                      thickness: 0.5,
                    )
                  ],
                );
              })),
    );
  }
}
