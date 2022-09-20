import 'package:get/get.dart';
import 'package:instagram_clone_coding/model/instagram_user.dart';
import 'package:instagram_clone_coding/src/repository/user_repository.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  Rx<InstagramUser> user = InstagramUser().obs; // 유저의 정보를 가지고 있고.
  Future<InstagramUser?> loginUser(String uid) async {
    //DB 조회
    var userData = await UserRepository.loginUserByUid(uid);
    print(userData);
    print(uid);
    return userData;
  }

  void signup(InstagramUser signupUser) async {
    // 받은 데이터 조합을 통해 InstagramUser 객체가 나왔다. 이제 이 값을 Map 함수로 변경?(안해도 될것같은데)
    // FireStore 에 값을 저장하는 걸 넣으면 된다. 역시 데이터베이스를 다루므로 user_repository 에다가 만들어주고 여기서는
    // 그냥 실행시키는 걸로 하면 좋지..
    var result = await UserRepository.signupUser(signupUser);
    if (result == true) {
      // signup 이 되었다는 뜻
      user(
          signupUser); // 컨트롤러의 user 객체에다가 signupUser 객체를 담아준다. // 여기 값을 넣는것 생소하지만 알고 있지??
    }
  }
}
