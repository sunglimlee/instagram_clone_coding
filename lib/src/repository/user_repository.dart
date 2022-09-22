import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone_coding/model/instagram_user.dart';

class UserRepository {
  // 값을 확인하는 부분이고
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
      //print(data.docs.first.data()); // 이부분인데 에러인줄 알았잖아..!!!!!
      // 헷갈리지 말자. 먼저 파이어스토어에서 확인하고 나서 값이 있으면 InstagramUser() 객체를 넘겨준다.
      return InstagramUser.fromJson(data.docs.first.data());
    }
  }

  // 값이 저장되는 부분이고
  static Future<bool> signupUser(InstagramUser signupUser) async {
    // 여기서 실제로 데이터 베이스 연결과 업데이트가 이루어진다.
    // 그런데 여기서 instance 를 계속 만들어줘야하나????? 그냥 하나 만들어놓고 쓰면 안되나? 충돌나나? 그래서인가?
    // 여기서 보면 map 으로 바뀌어서 저장이 되어야 한다.
    try {
      // 헷갈렸다. signupUser 에 이미 변수들이 입력되어있는거잖아.
      await FirebaseFirestore.instance
          .collection('users')
          .add(signupUser.toMap());
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
