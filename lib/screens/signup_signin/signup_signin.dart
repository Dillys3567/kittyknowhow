import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kittyknowhow/components/custom_signup_button.dart';
import 'package:kittyknowhow/screens/home/home_page.dart';
import 'package:kittyknowhow/screens/signup_signin/signin_page.dart';
import 'package:kittyknowhow/screens/signup_signin/signup_page.dart';
import 'package:kittyknowhow/utils/constants.dart';

class SignUpSignInPage extends StatefulWidget {
  const SignUpSignInPage({super.key});

  @override
  State<SignUpSignInPage> createState() => _SignUpSignInPageState();
}

class _SignUpSignInPageState extends State<SignUpSignInPage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        SystemNavigator.pop();
      },
      child: Scaffold(
        backgroundColor: Color(-1514516),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/pawprint.png',
                  width: 150,
                  height: 150,
                ),
                Text(
                  'KittyKnowhow',
                  style: signupHeading,
                ),
                SizedBox(
                  height: 30,
                ),
                CustomSignUpButton(
                    buttonText: 'Sign Up',
                    functionCall: () => Navigator.of(context)
                            .push(MaterialPageRoute(builder: (builder) {
                          return SignUpPage();
                        }))),
                SizedBox(
                  height: 30,
                ),
                CustomSignUpButton(
                    buttonText: 'Sign In',
                    functionCall: () => Navigator.of(context)
                            .push(MaterialPageRoute(builder: (builder) {
                          return SignInPage();
                        }))),
                SizedBox(
                  height: 30,
                ),
                MaterialButton(
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomePage())),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Learn without an account',
                        style: smallSignUpText,
                      ),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: Color(-6656375),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Text(
                        "Let's learn together to care for",
                        style: smallSignUpText,
                      ),
                      Text(
                        " our fur babies!",
                        style: smallSignUpText,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
