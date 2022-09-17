import 'package:flutter/material.dart';
import 'package:instagram_clone_coding/widgets/avatar_widget.dart';

class UserCard extends StatelessWidget {
  final String userId;
  final String description;

  const UserCard({required this.userId, required this.description, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      width: 100,
      height: 200,
      decoration: BoxDecoration(
          //color: Colors.red,
          borderRadius: BorderRadius.circular(3),
          border: Border.all(color: Colors.black12)),
      child: Stack(children: [
        Positioned(
          left: 0,
          top: 0,
          right: 0,
          bottom: 0,
          // Container()를 Positioned() 로 감싸고 위치를 전부 0으로 세팅하면 전체를 차지한다.
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  height: 10,
                ),
                AvatarWidget(
                  type: AvatarType.TYPE2,
                  thumbPath:
                      'https://thumbs.dreamstime.com/b/photo-portrait-cheerful-cool-swag-trend-trendy-guy-leaving-his-feedback-social-media-network-using-smart-phone-photo-145377495.jpg',
                  size: 80,
                ),
                Expanded(
                  child: Text(
                    userId,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  description,
                  style:
                      const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(onPressed: () {}, child: const Text('Follow'))
              ]),
        ),
        Positioned(
          right: 5,
          top: 5,
          child: GestureDetector( // GestureDetector 이 어딘지 모르니깐 그런 문제가 생겼네..
            onTap: () {},
            child: const Icon(
              Icons.close,
              size: 14,
              color: Colors.grey,
            ),
          ),
        ),
      ]),
    );
  }
}
