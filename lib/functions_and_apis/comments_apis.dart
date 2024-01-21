import 'package:kittyknowhow/functions_and_apis/posts_api.dart';
import 'package:kittyknowhow/functions_and_apis/user_info.dart';
import 'package:kittyknowhow/models/comment.dart';
import 'package:kittyknowhow/utils/constants.dart';

//comment class containing function calls for comments

class CommentsApiService {
  //gets all comment ids for a particular post using the post id
  Future getAllComment() async {
    final response = await supabase.from('comment').select('post_id,id');
    return response;
  }

  //creates a new comment
  Future createComment(String userId, String text, String postId) async {
    try {
      final response = await supabase
          .from('comment')
          .insert({'user_id': userId, 'text': text, 'post_id': postId});
    } catch (e) {
      throw Exception(e);
    }
  }

  //gets all comments for a particular post
  Future getPostComments(String postId) async {
    var userNames = {};
    var ids = [];
    PostsApiService postsApiService = PostsApiService();
    try {
      final response = await supabase
          .from('comment')
          .select('id,text,user_id,created_at')
          .eq('post_id', postId);

      response.forEach((element) {
        ids.add(element['user_id']);
      });

      final response2 = await getUserNameById(ids);

      response2.forEach((element) {
        userNames[element['id']] = element['name'];
      });

      List<Comment> comments = response.map((e) {
        return Comment(
            date: e['created_at'],
            id: e['id'],
            userId: e['user_id'],
            postId: postId,
            text: e['text'],
            userName: userNames[e['user_id']]);
      }).toList();
      return comments;
    } catch (e) {
      throw Exception(e);
    }
  }
}
