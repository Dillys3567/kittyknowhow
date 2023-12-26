import 'package:kittyknowhow/utils/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> addPet(
    dynamic user_id, String pet_name, String breed, String age) async {
  try {
    final response = await supabase.from('pet').insert(
        {'user_id': user_id, 'pet_name': pet_name, 'breed': breed, 'age': age});
  } catch (error) {
    print(error);
  }
}
