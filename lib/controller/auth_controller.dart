import 'package:get/get.dart';
import 'package:instagram_clone_coding/src/repository/user_repository.dart';

class AuthController extends GetxController {
  Future<bool?> loginUser(String uid) async {
    //DB 조회
    var userData = await UserRepository.loginUserByUid(uid);
    print(userData);
    print(uid);
    return userData;
  }
}
