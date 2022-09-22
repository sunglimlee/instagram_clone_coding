import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone_coding/model/post.dart';

class PostRepository {
  static Future<void> updatePost(Post postData) async {
    await FirebaseFirestore.instance.collection('posts').add(postData.toMap());
  }

  static Future<List<Post>> loadFeedList() async {
    // 데이터를 불러오는 부분
    var document = FirebaseFirestore.instance.collection('posts').orderBy('createdAt', descending: true).limit(10);
    var data = await document.get();
    // 내가 이걸 100% 이해하고 있구나.. 참 많이 늘었다.
    // map 과 그 map 을 가지고 Post.fromJson 을 이용해서 객체 Post 를 만들고, 결국 List<Post> 만들어지고
    // async, await, Future<List<Post>> 이 내용도 100% 알고 있는거네..
    return data.docs.map<Post>((e) => Post.fromJson(e.id, e.data())).toList();
  }
}