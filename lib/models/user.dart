import 'package:flutter/material.dart';

class User {
  String email;
  String name;

  User({required this.email, required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(email: json['email'], name: json['name']);
  }
}
