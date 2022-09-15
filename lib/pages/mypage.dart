import 'package:flutter/material.dart';
import 'package:instagram_clone_coding/widgets/avatar_widget.dart';
import 'package:instagram_clone_coding/widgets/image_data.dart';
import 'package:get/get.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // https://stackoverflow.com/questions/10330425/how-do-i-export-a-git-log-to-a-text-file
    // [question] Git commits to txt, 근데 폰트가 여전히 깨지고 있다.
    // [answer] git log > commits.txt
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          '개발하는 남자',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: ImageData(
              icon: IconsPath.uploadIcon,
              width: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              onTap: () {},
              child: ImageData(
                icon: IconsPath.menuIcon,
                width: 50,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 총 5개정도의 영역을 나눠주면서 작업을 할거다.
            _information(),
            _menu(),
          ],
        ),
      ),
    );
  }

  Widget _information() {
    Widget _staticsOne(String title, int value) {
      return Column(
        children: [
          Text(
            value.toString(),
            style: const TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Row(
            children: [
              AvatarWidget(
                thumbPath:
                    'https://thumbs.dreamstime.com/b/photo-portrait-cheerful-cool-swag-trend-trendy-guy-leaving-his-feedback-social-media-network-using-smart-phone-photo-145377495.jpg',
                type: AvatarType.TYPE3,
                size: 80,
              ),
              // 오른쪽에 전부다 차지하게 하려면
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // 균등하게 보이도록 Expanded 를 각각 감싸준다.
                  Expanded(child: _staticsOne('Post', 15)),
                  Expanded(child: _staticsOne('Followers', 15)),
                  Expanded(child: _staticsOne('Following', 15)),
                ],
              ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
              color: Colors.transparent,
              child: const Text(
                '안녕하세요. Steve 입니다. 구독과 좋아요 부탁드립니다!.~',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                ),
              )),
        ),
      ],
    );
  }

  Widget _menu() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
      child: Row(
        children: [
          Expanded(
              child: Container(
            // container 에도 alignment 가 있는데 Text 에다가 textAlign 을 주었다.
            padding: const EdgeInsets.symmetric(vertical: 7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(color: const Color(0xffdedede))),
            child: const Text(
              'Edit profile',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          )),
          const SizedBox(
            width: 10,
          ),
          Container(
            width: Get.width * 0.08,
            // container 에도 alignment 가 있는데 Text 에다가 textAlign 을 주었다.
            padding: const EdgeInsets.symmetric(vertical: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border.all(color: const Color(0xffdedede)),
              color: const Color(0xffefefef),
            ),
            child: ImageData(
              // 잘봐라. 지금 이미지로 구현하고 있다.
              icon: IconsPath.addFriend,
            ),
          ),
        ],
      ),
    );
  }
}
