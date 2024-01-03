import 'package:kittyknowhow/models/post.dart';

import '../utils/constants.dart';

class PostsApiService {
  Future createPost(
      String user_id, String title, String body, String? image) async {
    try {
      final response = await supabase.from('post').insert(
          {'user_id': user_id, 'title': title, 'body': body, 'image': image});
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Post>> getPosts() async {
    try {
      final response = await supabase
          .from('post')
          .select('*')
          .order('created_at', ascending: false);

      List<Post> posts = response.map((e) {
        return Post(
            id: e['id'],
            user_id: e['user_id'],
            title: e['title'],
            body: e['body'],
            image: e['image'],
            like: e['like']);
      }).toList();
      return (posts);
    } catch (e) {
      throw Exception(e);
    }
  }
}
