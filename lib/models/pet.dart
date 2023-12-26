import 'package:flutter/material.dart';

class Pet {
  String petName;
  String breed;
  String age;

  Pet({required this.petName, required this.breed, required this.age});

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
        petName: json['petName'], breed: json['breed'], age: json['age']);
  }
}
