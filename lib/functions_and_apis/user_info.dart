import 'package:kittyknowhow/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
