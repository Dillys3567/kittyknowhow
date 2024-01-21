import 'package:kittyknowhow/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

//gets username of a particular user using id
Future<String> getUsername() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final response = await supabase
      .from('user')
      .select('name')
      .eq('id', supabase.auth.currentUser!.id);

  final ownerName = response[0]['name'];

  sharedPreferences.setString('name', ownerName);
  return ownerName;
}

//get a list of user names using ids
Future getUserNameById(List userIds) async {
  try {
    final response =
        await supabase.from('user').select('name,id').inFilter('id', userIds);
    return response;
  } catch (e) {
    throw Exception(e);
  }
}
