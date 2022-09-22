import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_coding/controller/home_controller.dart';
import 'package:instagram_clone_coding/widgets/avatar_widget.dart';
import 'package:instagram_clone_coding/widgets/image_data.dart';
import 'package:instagram_clone_coding/widgets/post_widget.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 지금 Navigation 을 통해서 이게 들어온게 아니고 여기서 하위의 것이 나왔기 때문에 여기에는 계속 그대로 있다는 거지..
    // 그러니깐 이게 계속 그대로 있는거지.. 내생각이 맞았어.. 이거 그대 살아 있다는거야..
    Get.put(HomeController());
    return Scaffold(
      appBar: _myAppBar(),
      body: _myBody(),
    );
  }

  _myAppBar() {
    return AppBar(
      elevation: 0,
      title: ImageData(
        icon: IconsPath.logo,
        width: 270,
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ImageData(
              icon: IconsPath.directMessage,
              width: 50,
            ),
          ),
        ),
      ],
    );
  }

  _myBody() {
    return ListView(
      children: [
        _myBodyStoryBoardList(),
        _myBodyPostList(),
      ],
    );
  }

  Widget _myBodyStoryBoardList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        const SizedBox(
          width: 20,
        ),
        _myStory(),
        const SizedBox(
          width: 4,
        ),
        // [question] The element type 'List<Container>' can't be assigned to the list type 'Widget'.
        // [answer] Row 의 children 이 List [] 인데 지금 List 를 리턴하니깐 [] 를 없애주어야지..
        ...List.generate(
            // 배열을 계속 나열하겠다는 뜻임.
            100,
            (index) => AvatarWidget(
                thumbPath:
                    'https://media-cldnry.s-nbcnews.com/image/upload/t_fit-760w,f_auto,q_auto:best/rockcms/2022-04/220428-dog-breeds-mb-1019-95b354.jpg',
                type: AvatarType.TYPE1)),
      ]),
    );
  }

  Widget _myStory() {
    return Stack(
      children: [
        AvatarWidget(
          thumbPath:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5W2qWDdF7ztjYI9lL_odxd3LY3uv8BOI9Ug&usqp=CAU',
          type: AvatarType.TYPE2,
          size: 70,
        ),
        Positioned(
          right: 1,
          bottom: 0,
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.purple,
                border: Border.all(color: Colors.white, width: 2)),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  _myBodyPostList() {
    return Obx(
      () => Column(
        children: List.generate(
                controller.postList.length, (index) => PostWidget(post: controller.postList[index]))
            .toList(),
      ),
    );
  }
}
