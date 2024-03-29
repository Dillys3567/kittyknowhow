//Pet object
class Pet {
  String image;
  String? petId;
  String? ownerId;
  String petName;
  String breed;
  String age;
  String bio;

  Pet(
      {this.petId,
      this.ownerId,
      required this.petName,
      required this.breed,
      required this.age,
      this.bio = "",
      this.image = ''});

  //returns new Pet object
  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
        image: json['image'],
        petId: json['petId'],
        ownerId: json['ownerId'],
        petName: json['petName'],
        breed: json['breed'],
        age: json['age'],
        bio: json['bio'] ?? "");
  }
}
