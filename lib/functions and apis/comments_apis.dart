import 'package:flutter/material.dart';
import 'package:kittyknowhow/utils/constants.dart';

class CommentsApiService {
  Future getAllComment() async {
    final response = await supabase.from('comment').select('post_id,id');
    return response;
  }

  Future createComment(String userId, String text, String postId) async {
    try {
      final response = await supabase
          .from('comment')
          .insert({'user_id': userId, 'text': text, 'post_id': postId});
    } catch (e) {
      throw Exception(e);
    }
  }

  Future getPostComments(String postId) async {
    try {
      final response = await supabase
          .from('comment')
          .select('user_id,text')
          .eq('post_id', postId);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}
