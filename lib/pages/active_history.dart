import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_coding/widgets/avatar_widget.dart';

class ActiveHistory extends StatelessWidget {
  const ActiveHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true, // 이렇게 Appbar 의 title 을 중앙정렬할 수 있구나.
        elevation: 0,
        title: const Text(
          '활동',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _newRecentlyView('오늘'),
            _newRecentlyView('이번주'),
            _newRecentlyView('이번달'),
          ],
        ),
      ),
    );
  }


  Widget _newRecentlyView(String title) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      // 집중해라. 그냥 Column 전체 바깥쪽에 공간을 둔다.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // 전체사용공간 확보로 가로정렬 막아준다.
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          _activeItemOne(),
          _activeItemOne(),
          _activeItemOne(),
          _activeItemOne(),
          _activeItemOne(),
        ],
      ),
    );
  }

  Widget _activeItemOne() {
    // code expand shortcut ctrl + '+' or '-'
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          AvatarWidget(
            thumbPath:
            'https://thumbs.dreamstime.com/b/photo-portrait-cheerful-cool-swag-trend-trendy-guy-leaving-his-feedback-social-media-network-using-smart-phone-photo-145377495.jpg',
            type: AvatarType.TYPE2,
            size: 40,
          ),
          const SizedBox(
            width: 10,
          ),
          const Expanded(
            child: Text.rich(TextSpan(
                text: '개남',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: '님이 회원님의 게시물을 좋아합니다. 계속 활동을 부탁드립니다. 현재 많은 분들이 우크라이나 전쟁에 대해서 이야기 하고 있습니다.',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextSpan(
                    text: ' 5 일전',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 13,
                        color: Colors.black54),
                  ),
                ])),
          )
        ],
      ),
    );
  }

}
