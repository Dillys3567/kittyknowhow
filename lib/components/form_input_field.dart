import 'package:flutter/material.dart';
import 'package:kittyknowhow/utils/constants.dart';

//custom input field for sign up and sign in screen

class FormInputField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool showIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final String? Function(String?)? validator;

  FormInputField(
      {super.key,
      required this.label,
      required this.controller,
      required this.keyboardType,
      required this.showIcon,
      this.suffixIcon,
      this.obscureText,
      required this.validator});

  @override
  State<FormInputField> createState() => _FormInputFieldState();
}

class _FormInputFieldState extends State<FormInputField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      validator: widget.validator,
      obscureText: widget.obscureText ?? false,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
          suffixIcon: (widget.showIcon) ? widget.suffixIcon : Column(),
          labelText: widget.label,
          labelStyle: smallSignUpText,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(-2507562)),
              borderRadius: BorderRadius.circular(15))),
    );
  }
}
