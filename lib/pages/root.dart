import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_coding/controller/auth_controller.dart';
import 'package:instagram_clone_coding/model/instagram_user.dart';
import 'package:instagram_clone_coding/pages/login.dart';
import 'package:instagram_clone_coding/pages/signup_page.dart';
import 'package:instagram_clone_coding/src/app/app.dart';

class Root extends GetView<AuthController> {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // 기억하자. 이것도 객체이다. 그래서 여기에서 감싸는 App() 이니깐 사실상 가장 최상단이지..
      stream: FirebaseAuth.instance.authStateChanges(),
      // user sign-in 이나 sign-out 등등 유저의 상태가 바뀌었을 때, 스트림을 해주겠다.
      // login 작업을 할 것이고 User 객체를 다룰거기 때문에 AsyncSnapShot 은 User 가될것이다.
      // Firebase_auth 에서 User 가 자동으로 넘어온다.
      builder: (BuildContext _, AsyncSnapshot<User?> user) {
        if (user.hasData) {
          // TODO 내부 파이어베이스 유저 정보를 조회 with user.data.uid
          var result = controller.loginUser(
              user.data!.uid.toString()); // 여기서 InstagramUser() 객체가 만들어졌다.
          return FutureBuilder<InstagramUser?>(
              // 여기서 비교해서 뭔가를 작업하겠다는 거지?
              future: result,
              builder: (context, snapshot) {
                // 이제 snapshot 은 InstagramUser() 객체이지
                // 데이터가 존재하는지 확인하고
                if (snapshot.hasData) {
                  return const App();
                } else {
                  return const SignupPage();
                }
              });
        } else {
          return const Login();
        }
      },
    );
  }
}
