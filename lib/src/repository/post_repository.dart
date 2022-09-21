import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone_coding/model/post.dart';

class PostRepository {
  static Future<void> updatePost(Post postData) async {
    await FirebaseFirestore.instance.collection('posts').add(postData.toMap());
  }
}