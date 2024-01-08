import 'package:kittyknowhow/functions%20and%20apis/comments_apis.dart';
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
        print(commentCount);
      });
      List posts = response.map((e) {
        print(response2.map((x) {
          userNames[x['id']] = x['name'];
          return (x['name']);
        }));
        return Post(
          id: e['id'],
          user_id: e['user_id'],
          title: e['title'],
          body: e['body'],
          image: e['image'],
          userName: userNames[e['user_id']],
          comment: commentCount[e['id']],
        );
      }).toList();
      print(ids);
      print(userNames);
      print(response3);
      print(commentCount);
      return (posts);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future getUserNameById(List userIds) async {
    try {
      final response =
          await supabase.from('user').select('name,id').inFilter('id', userIds);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

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
        print(commentCount);
      });
      List posts = response.map((e) {
        print(response2.map((x) {
          userNames[x['id']] = x['name'];
          return (x['name']);
        }));
        return Post(
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
