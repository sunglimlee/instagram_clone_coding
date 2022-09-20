import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_coding/controller/auth_controller.dart';
import 'package:instagram_clone_coding/controller/signup_controller.dart';
import 'package:instagram_clone_coding/model/instagram_user.dart';

class SignupPage extends GetView<SignupController> {
  SignupPage({Key? key, required this.uid}) : super(key: key);
  String uid;

  @override
  Widget build(BuildContext context) {
    Get.put(SignupController());
    return Scaffold(
      backgroundColor: Colors.purple[200],
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        elevation: 0,
        centerTitle: true,
        title: const Text(
          '회원가입',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // 글자는 왼쪽어었던것같은데 ClipRRect 는 중앙 정렬인가?
          children: [
            const SizedBox(
              height: 30,
            ),
            _avatar(),
            const SizedBox(
              height: 30,
            ),
            _nickName(),
            const SizedBox(
              height: 30,
            ),
            _description(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(50),
        child: ElevatedButton(
          onPressed: () {
            //print(controller.nickNameController.text);
            //print(controller.descriptionController.text);
            //TODO : Validation 작업이 이루어져야 하지..
            var signupUser = InstagramUser(
                uid: uid,
                nickname: controller.nickNameController.text,
                description: controller.descriptionController.text);
            AuthController.to.signup(signupUser);
          },
          child: const Text('회원가입'),
        ),
      ),
    );
  }

  Widget _avatar() {
    return Column(
      children: [
        ClipRRect(
          // 기억나지? 동그라미 모양의 위젯을 만들때 사용했던 위젯
          borderRadius: BorderRadius.circular(100),
          child: SizedBox(
            width: 100,
            height: 100,
            child: Image.asset('assets/images/default_image.png',
                fit: BoxFit.cover), // 꽉채워준다.
          ),
        ),
        ElevatedButton(
            onPressed: () {
              // TODO 이미지 변경하는 부분도 해야함. Firebase Storage 에 저장하고 불러들이는 기능이다.
            },
            child: const Text('이미지 변경'))
      ],
    );
  }

  Widget _nickName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: TextField(
        // 값을 넣어주는 TextField, Validation 하는것과, Key 값을 가지고 있었다는것 다 기억하지? 그리고 setState,
        controller: controller.nickNameController,
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(10), hintText: '닉네임'),
      ),
    );
  }

  Widget _description() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: TextField(
        // 값을 넣어주는 TextField, Validation 하는것과, Key 값을 가지고 있었다는것 다 기억하지? 그리고 setState,
        controller: controller.descriptionController,
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(10), hintText: '설명'),
      ),
    );
  }
}
