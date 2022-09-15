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
            _newRecentlyActiveView(),
            _newRecentlyThisWeekView(),
            _newRecentlyThisMonthView(),
          ],
        ),
      ),
    );
  }

  Widget _newRecentlyActiveView() {
    Widget _activeItemOne() {
      // code expand shortcut ctrl + '+' or '-'
      return Row(
        children: [
          AvatarWidget(
            thumbPath:
                'https://thumbs.dreamstime.com/b/photo-portrait-cheerful-cool-swag-trend-trendy-guy-leaving-his-feedback-social-media-network-using-smart-phone-photo-145377495.jpg',
            type: AvatarType.TYPE3,
            size: 40,
          )
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      // 집중해라. 그냥 Column 전체 바깥쪽에 공간을 둔다.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // 전체사용공간 확보로 가로정렬 막아준다.
        children: [
          const Text(
            '오늘',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          _activeItemOne(),
        ],
      ),
    );
  }

  Widget _newRecentlyThisWeekView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      // 집중해라. 그냥 Column 전체 바깥쪽에 공간을 둔다.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // 전체사용공간 확보로 가로정렬 막아준다.
        children: const [
          Text(
            '이번주',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _newRecentlyThisMonthView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      // 집중해라. 그냥 Column 전체 바깥쪽에 공간을 둔다.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // 전체사용공간 확보로 가로정렬 막아준다.
        children: const [
          Text(
            '이번달',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
