import 'package:flutter/material.dart';
import 'package:instagram_clone_coding/widgets/avatar_widget.dart';
import 'package:instagram_clone_coding/widgets/image_data.dart';

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
          ],
        ),
      ),
    );
  }

  Widget _information() {
    Widget _staticsOne(String title, int value) {
      return Column(
        children: [
          Text(value.toString(), style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold ),),
          Text(title, style: const TextStyle(fontSize: 15, color: Colors.black, ),),
        ],
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Row(
            children: [
              AvatarWidget(
                  thumbPath:
                      'https://thumbs.dreamstime.com/b/photo-portrait-cheerful-cool-swag-trend-trendy-guy-leaving-his-feedback-social-media-network-using-smart-phone-photo-145377495.jpg',
                  type: AvatarType.TYPE3, size: 80,),
              // 오른쪽에 전부다 차지하게 하려면
              Expanded(child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // 균등하게 보이도록 Expanded 를 각각 감싸준다.
                Expanded(child: _staticsOne('Post', 15)),
                Expanded(child: _staticsOne('Followers', 15)),
                Expanded(child: _staticsOne('Following', 15)),

              ],))
            ],
          ),
        ),
      ],
    );
  }
}
