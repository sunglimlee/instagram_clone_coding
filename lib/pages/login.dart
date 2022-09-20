import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0 ,
        title: const Text(
          'Login(로그인)',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: ElevatedButton(onPressed: (){
          signInWithGoogle();
        }, child: const Text('구글 로그인')),
      ),
    );
  }

  // Firebase 공식문서 Social Auth 에서 복사한 내용
  // 맨마지막에서 Future<UserCredential> 을 리턴하니깐 이렇게 리턴 타입을 적어놓은거지.
  Future<UserCredential> signInWithGoogle() async { // Future 사용되니깐 async 되어야하고
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn(); // Sign-in 할 때까지 기다리고

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication; // 허가를 받았느냐 기다리고

    // Create a new credential
    final credential = GoogleAuthProvider.credential( // credential 만들고
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential); // credential 넣어서 FirebaseAuth 에 Signin
  }
}
