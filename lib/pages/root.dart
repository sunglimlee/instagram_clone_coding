import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_coding/src/app/app.dart';

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      // user sign-in 이나 sign-out 등등 유저의 상태가 바뀌었을 때, 스트림을 해주겠다.
      // login 작업을 할 것이고 User 객체를 다룰거기 때문에 AsyncSnapShot 은 User 가될것이다.
      // Firebase_auth 에서 User 가 자동으로 넘어온다.
      builder: (BuildContext _, AsyncSnapshot<User?> user) {
        if (user.hasData) {
          return const App();
        } else {
          return Container();
        }
      },
    );
  }
}
