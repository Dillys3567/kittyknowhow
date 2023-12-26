import 'package:flutter/material.dart';
import 'package:kittyknowhow/utils/constants.dart';

class CustomSignUpButton extends StatefulWidget {
  final String buttonText;
  final functionCall;
  const CustomSignUpButton(
      {super.key, required this.buttonText, required this.functionCall});

  @override
  State<CustomSignUpButton> createState() => _CustomSignUpButtonState();
}

class _CustomSignUpButtonState extends State<CustomSignUpButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: widget.functionCall,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
            color: Color(-2507562),
            border: Border.all(color: Colors.transparent),
            borderRadius: BorderRadius.circular(15)),
        child: Text(
          widget.buttonText,
          style: signupButtonText,
        ),
      ),
    );
  }
}
