import 'package:flutter/material.dart';
import 'package:instagram_clone_coding/controller/mypage_controller.dart';
import 'package:instagram_clone_coding/widgets/avatar_widget.dart';
import 'package:instagram_clone_coding/widgets/image_data.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_coding/widgets/user_card.dart';

// 맨마지막 페이지잖아.
// Stateful 이 아니니깐 문제가 생기네..
// 초기화는 어디서 할거며, 인터페이스는 어떻게 상속 받을 것인가?
class MyPage extends GetView<MyPageController> {
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
        title: Obx(
          () => Text(
            controller.targetUser.value.nickname ?? 'Anonymous',
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
          ),
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
            _discoverPeople(),
            const SizedBox(
              height: 20,
            ),
            _tabMenu(),
            _tabView(),
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
              Obx(
                () => AvatarWidget(
                  thumbPath: controller.targetUser.value.thumbnail ??
                      'https://thumbs.dreamstime.com/b/photo-portrait-cheerful-cool-swag-trend-trendy-guy-leaving-his-feedback-social-media-network-using-smart-phone-photo-145377495.jpg',
                  type: AvatarType.TYPE3,
                  size: 80,
                ),
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
        Obx(
          () => Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                color: Colors.transparent,
                child: Text(
                  controller.targetUser.value.description ?? '구독과 좋아요 부탁드립니다.',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                )),
          ),
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

  Widget _discoverPeople() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Discover People',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black),
              ),
              Text(
                'See All',
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
                20,
                (index) => UserCard(
                    userId: '개남$index',
                    description: '개남$index님이 팔로우합니다.')).toList(),
          ),
        ),
      ],
    );
  }

  Widget _tabMenu() {
    // TabBar 사용
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TabBar(
          indicatorColor: Colors.black,
          indicatorWeight: 1,
          controller: controller.tabController,
          tabs: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ImageData(icon: IconsPath.gridViewOn),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ImageData(icon: IconsPath.gridViewOff),
            ),
          ]),
    );
  }

  Widget _tabView() {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 100,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.grey,
            child: Image.network(
              'https://d3544la1u8djza.cloudfront.net/APHI/Blog/2020/05-14/How+Do+Dogs+Get+Hernias+_+ASPCA+Pet+Insurance+_+shiba+inu+with+an+orange+collar+resting+on+a+tan+chair-min.jpg',
              fit: BoxFit.cover,
            ),
          );
        });
  }
}
