import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

TextStyle signupHeading = TextStyle(
    fontFamily: 'IndieFlower',
    fontWeight: FontWeight.w900,
    fontSize: 60,
    color: Color(-6656375));

TextStyle signupButtonText = TextStyle(
    fontFamily: 'IndieFlower',
    fontWeight: FontWeight.w900,
    fontSize: 30,
    color: Color(-6656375));

TextStyle profileNameText = TextStyle(
    fontFamily: 'IndieFlower',
    fontWeight: FontWeight.w900,
    fontSize: 30,
    color: Colors.white);

TextStyle appBarText = TextStyle(
    fontFamily: 'IndieFlower',
    fontWeight: FontWeight.w900,
    fontSize: 30,
    color: Color(-1514516));

TextStyle smallSignUpText = TextStyle(
    fontFamily: 'IndieFlower',
    fontWeight: FontWeight.w900,
    fontSize: 18,
    color: Color(-6656375));

final supabase = Supabase.instance.client;

extension ShowSnackBar on BuildContext {
  void showSnackBar(
      {required String message, Color backgroundColor = Colors.white}) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Color(-6656375)),
      ),
      backgroundColor: backgroundColor,
    ));
  }

  void showErrorSnackBar({required String message}) {
    showSnackBar(message: message, backgroundColor: Colors.red);
  }
}
