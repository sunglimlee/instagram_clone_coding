import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone_coding/model/instagram_user.dart';

class UserRepository {
  // async 로 마크 되어 있는건 반드시 Future 로 되어야 한다.
  static Future<InstagramUser?> loginUserByUid(String uid) async {
    // 그냥 FirebaseFirestore 바로 사용하네..
    var data = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get();
    if (data.size == 0) {
      return null;
    } else {
      print(data.docs.first.data());
      // 헷갈리지 말자. 먼저 파이어스토어에서 확인하고 나서 값이 있으면 InstagramUser() 객체를 넘겨준다.
      return InstagramUser.fromJson(data.docs.first.data());
    }
  }
}
