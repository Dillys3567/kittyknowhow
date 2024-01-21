import 'package:kittyknowhow/functions_and_apis/comments_apis.dart';
import 'package:kittyknowhow/models/post.dart';
import 'package:kittyknowhow/functions_and_apis/user_info.dart';
import '../utils/constants.dart';

//APIs for posts
class PostsApiService {
  //creates a new post
  Future createPost(
      String user_id, String title, String body, String? image) async {
    try {
      final response = await supabase.from('post').insert(
          {'user_id': user_id, 'title': title, 'body': body, 'image': image});
    } catch (e) {
      throw Exception(e);
    }
  }

  //gets all posts in database
  Future getPosts() async {
    CommentsApiService commentsApiService = CommentsApiService();
    try {
      var userNames = {};
      var commentCount = {};
      final response = await supabase
          .from('post')
          .select('*')
          .order('created_at', ascending: false);
      final ids = response.map((e) {
        return e['user_id'].toString();
      }).toList();
      final response2 = await getUserNameById(ids);
      final response3 = await commentsApiService.getAllComment();
      response3.forEach((y) {
        if (commentCount[y['post_id']] == null) {
          commentCount[y['post_id']] = 1;
        } else
          commentCount[y['post_id']] += 1;
      });
      List posts = response.map((e) {
        print(response2.map((x) {
          userNames[x['id']] = x['name'];
          return (x['name']);
        }));
        return Post(
          date: e['created_at'],
          id: e['id'],
          user_id: e['user_id'],
          title: e['title'],
          body: e['body'],
          image: e['image'],
          userName: userNames[e['user_id']],
          comment: commentCount[e['id']],
        );
      }).toList();
      return (posts);
    } catch (e) {
      throw Exception(e);
    }
  }

  //gets the posts of a particular user
  Future getMyPosts(String userId) async {
    CommentsApiService commentsApiService = CommentsApiService();
    try {
      var userNames = {};
      var commentCount = {};
      final response = await supabase
          .from('post')
          .select('*')
          .eq('user_id', userId)
          .order('created_at', ascending: false);
      final ids = response.map((e) {
        return e['user_id'].toString();
      }).toList();
      final response2 = await getUserNameById(ids);
      final response3 = await commentsApiService.getAllComment();
      response3.forEach((y) {
        if (commentCount[y['post_id']] == null) {
          commentCount[y['post_id']] = 1;
        } else
          commentCount[y['post_id']] += 1;
      });
      List posts = response.map((e) {
        print(response2.map((x) {
          userNames[x['id']] = x['name'];
          return (x['name']);
        }));
        return Post(
          date: e['created_at'],
          id: e['id'],
          user_id: e['user_id'],
          title: e['title'],
          body: e['body'],
          image: e['image'],
          userName: userNames[e['user_id']],
          comment: commentCount[e['id']],
        );
      }).toList();
      return (posts);
    } catch (e) {
      throw Exception(e);
    }
  }
}
