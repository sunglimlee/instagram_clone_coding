import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_coding/widgets/avatar_widget.dart';
import 'package:instagram_clone_coding/widgets/image_data.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // 잘보자. 전체를 늘려서 왼쪽부터 정렬시킨다.
        children: [
          _header(),
          const SizedBox(
            height: 15,
          ),
          _image(),
          const SizedBox(
            height: 15,
          ),
          _infoCount(),
          const SizedBox(
            height: 5,
          ),
          _infoDescription(),
          const SizedBox(
            height: 5,
          ),
          _replyTextBtn(),
          const SizedBox(
            height: 5,
          ),
          _dateAgo(),
        ],
      ),
    );
  }

  _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AvatarWidget(
            size: 40,
            nickName: '개발하는남자',
            thumbPath:
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5W2qWDdF7ztjYI9lL_odxd3LY3uv8BOI9Ug&usqp=CAU',
            type: AvatarType.TYPE3),
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ImageData(
              icon: IconsPath.postMoreIcon,
              width: 50,
            ),
          ),
        ),
      ],
    );
  }

  _image() {
    // 이거 너무 맘에 든다. 단지 imageUrl만 해주었는데 이렇게 이미지를 불러들여오는구나.
    return CachedNetworkImage(
      imageUrl:
          'https://image.cnbcfm.com/api/v1/image/105992231-1561667465295gettyimages-521697453.jpeg?v=1561667497',
    );
  }

  _infoCount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const SizedBox(
              width: 8,
            ),
            ImageData(
              icon: IconsPath.likeOffIcon,
              width: 65,
            ),
            const SizedBox(
              width: 15,
            ),
            ImageData(
              icon: IconsPath.replyIcon,
              width: 60,
            ),
            const SizedBox(
              width: 15,
            ),
            ImageData(
              icon: IconsPath.directMessage,
              width: 55,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: ImageData(
            icon: IconsPath.bookMarkOffIcon,
            width: 55,
          ),
        ),
      ],
    );
  }

  _infoDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '좋아요 150개',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          ExpandableText('컨텐츠1입니다.\n컨텐츠2입니다.\n컨텐츠3입니다.\n컨텐츠4입니다.\n컨텐츠5입니다.',
              prefixText: '개발하는남자',
              onPrefixTap: () {print('개남페이지로가자');} , // 이걸 선택하면 개발하는남자 페이지로 이동시킨다.
              prefixStyle: const TextStyle(fontWeight: FontWeight.bold),
              maxLines: 3, // 3번째부터 짤리게 된다..
              expandOnTextTap: true,
              collapseOnTextTap: true,
              expandText: '더보기',
          collapseText: '접기',
          linkColor: Colors.purple,),
        ],
      ),
    );
  }

  _replyTextBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        onTap: () {},
        child: const Text('댓글 199개 모두 보기', style: TextStyle(color: Colors.grey,),),
      ),
    );
  }

  _dateAgo() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Text('1일전', style: TextStyle(color: Colors.grey, fontSize: 11.0),),
    );
  }
}
