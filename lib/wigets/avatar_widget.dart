import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

enum AvatarType { TYPE1, TYPE2, TYPE3 }

class AvatarWidget extends StatelessWidget {
  bool? hasStory;
  String? nickName;
  String thumbPath;
  AvatarType type;
  double? size;

  AvatarWidget(
      {Key? key,
      this.size = 65,
      this.hasStory,
      this.nickName,
      required this.thumbPath,
      required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case AvatarType.TYPE1:
        return type1Widget();
      case AvatarType.TYPE2:
      return type2Widget();
      case AvatarType.TYPE3:
      return type3Widget();
      default:
        return Container();
    }
  }

  Widget type1Widget() {
    // Gradation 이 들어가야하는 위젯이다.
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.purple, Colors.orange]),
          shape: BoxShape.circle),
      child: type2Widget(),
    );
  }

  Widget type2Widget() {
    return Container(
      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      padding: const EdgeInsets.all(2),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(65), // 이걸 감싸주어야 동그랗게 잘라줄 수 있게 된다.
        child: SizedBox(
          width: size,
          height: size,
          child: CachedNetworkImage(
            imageUrl: thumbPath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
  Widget type3Widget() {
    //print('닉네임은 $nickName');
    return Row(
      children: [
        Row(
          children: [
            SizedBox(width: 20,),
            type1Widget(),
            SizedBox(width: 7,),
            // QnADartGrammar null 일땐 '' 공백을 주어라.
            Text(nickName??'', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),),
          ],
        ),
      ],
    );
  }
}



Widget type1WidgetTempBackup() {
  // Gradation 이 들어가야하는 위젯이다.
  return Container(
    width: 160,
    height: 160,
    margin: const EdgeInsets.symmetric(horizontal: 5),
    decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.purple, Colors.orange]),
        shape: BoxShape.circle),
    child: CachedNetworkImage(
      imageUrl: 'https://i.guim.co.uk/img/media/fe1e34da640c5c56ed16f76ce6f994fa9343d09d/0_174_3408_2046/master/3408.jpg?width=1200&height=900&quality=85&auto=format&fit=crop&s=0d3f33fb6aa6e0154b7713a00454c83d',
      placeholder: (context, url) => const CircleAvatar(
        backgroundColor: Colors.amber,
        radius: 150,
      ),
      imageBuilder: (context, image) => CircleAvatar(
        backgroundImage: image,
        radius: 150,
      ),
    ),
  );
}
