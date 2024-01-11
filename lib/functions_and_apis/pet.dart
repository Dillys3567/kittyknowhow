import 'package:kittyknowhow/models/pet.dart';
import 'package:kittyknowhow/utils/constants.dart';

Future<void> addPet(
    dynamic user_id, String pet_name, String breed, String age) async {
  try {
    final response = await supabase.from('pet').insert(
        {'user_id': user_id, 'pet_name': pet_name, 'breed': breed, 'age': age});
  } catch (error) {
    print(error);
  }
}

Future<List<Pet>> getPets() async {
  final response = await supabase
      .from('pet')
      .select('*')
      .eq('user_id', supabase.auth.currentUser!.id)
      .order('created_at', ascending: true);

  List<Pet> pets = response.map((e) {
    return Pet(
        image: e['image'],
        petId: e['id'],
        ownerId: e['user_id'],
        petName: e['pet_name'],
        breed: e['breed'],
        age: e['age'],
        bio: e['bio']);
  }).toList();
  return (pets);
}

Future updatePetBio(String bio, String petId) async {
  try {
    final response = await supabase
        .from('pet')
        .update({'bio': bio})
        .eq('id', petId)
        .select();
    return response;
  } catch (e) {
    throw Exception(e);
  }
}
