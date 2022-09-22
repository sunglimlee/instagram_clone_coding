import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_coding/controller/init_bindings.dart';
import 'package:instagram_clone_coding/model/instagram_user.dart';
import 'package:instagram_clone_coding/src/repository/user_repository.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  Rx<InstagramUser> user = InstagramUser().obs; // 유저의 정보를 가지고 있고.

  Future<InstagramUser?> loginUser(String uid) async {
    //DB 조회
    var userData = await UserRepository.loginUserByUid(uid);
    //print(userData);
    //print(uid);
    if (userData != null) {
      // 로그인이 가능하다는거지..
      user(userData);
      InitBindings.myPagesBinding();
    }
    return userData;
  }

  void signup(InstagramUser signupUser, [XFile? thumbnailXFile]) async {
    // 먼저 사진업로드를 먼저한다. 여기서보자. 사진을 업로드하면서 uid 를 같이 올리는지.. 그말은 하나만 올라간다는 거다.
    if (thumbnailXFile == null) {
      _submitSignup(signupUser);
    } else {
      // 사진이 있다면
      var extension =
          thumbnailXFile.path.split('.').last; // 점이 두개 있을 수도있으니깐 last 가 맞지.
      UploadTask uploadTask = _uploadXFile(
          thumbnailXFile, '${signupUser.uid.toString()}/profile.$extension');
      uploadTask.snapshotEvents.listen((event) async {
        print(event.bytesTransferred); // 올라간 바이트 값을 듣고 있다가 찍어준다.
        if (event.bytesTransferred == event.totalBytes &&
            event.state == TaskState.success) {
          // 이미지 파일이 전부다 업로드가 되었다면
          var downloadUrl = await event.ref.getDownloadURL();
          // 이렇게 복사를 하는 이유는 기존건 그대로 두고 사진파일만 있는 걸로 다시 객체를 하나 더 만든다고 생각하면 된다.
          var updatedUserData = signupUser.copyWith(thumbnail: downloadUrl);
          _submitSignup(updatedUserData);
        }
      });
    }
  }

  void _submitSignup(InstagramUser signupUser) async {
    // 받은 데이터 조합을 통해 InstagramUser 객체가 나왔다. 이제 이 값을 Map 함수로 변경?(안해도 될것같은데)
    // FireStore 에 값을 저장하는 걸 넣으면 된다. 역시 데이터베이스를 다루므로 user_repository 에다가 만들어주고 여기서는
    // 그냥 실행시키는 걸로 하면 좋지..
    var result = await UserRepository.signupUser(signupUser);
    if (result == true) {
      // signup 이 되었다는 뜻
      user(
          signupUser); // 컨트롤러의 user 객체에다가 signupUser 객체를 담아준다. // 여기 값을 넣는것 생소하지만 알고 있지??
      loginUser(signupUser.uid!);
    }
  }

  UploadTask _uploadXFile(XFile thumbnailXFile, String filename) {
    // 실제로 FireStore 에 저장하는 부분
    var f = File(thumbnailXFile.path);
    var ref = FirebaseStorage.instance.ref().child('users').child(filename);
    final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': thumbnailXFile.path});
    return ref.putFile(f, metadata);
  }
}
