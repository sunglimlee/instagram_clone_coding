import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_coding/pages/search_screen_detail.dart';
import 'package:quiver/iterables.dart';

// 왜 StatefulWidget 을 만들었을까?
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with TickerProviderStateMixin {
  // 여기에다가 tabController 를 만드는 구나.
  late TabController tabController;
  List<List<int>> groupBox = [[], [], []]; //3개의 컬럼에 있는 리스트별로 사이즈가 들어간다. (1, 2) 중에 하나로. // QnADartGrammar 2차배열
  List<int> groupIndex = [0,0,0]; // 전체 사이즈 합계를 체크하기 위한 리스트 // 라이브러리를 추가한다.quiver, 각 컬럼별 사이즈가 합계된다.

  @override
  void initState() { // 이게 왜 실행이 안되지???? // 최초 실행시 한번만 돌아간다. 이름 보면 모르겠나??? // 그러니깐 다시 빌드해야 보이지.!
    super.initState();
    for (var i=0; i< 100; i++) {
      var gi = groupIndex.indexOf(min<int>(groupIndex)!); // 여기 봐라. 0,1,2 중에서 제일 작은거 찾아서 인덱스(0,1,2) 를 넘겨줌.
      //var gi = i % 3;
      var size = 1;
      if (gi != 1) { // 그러니깐 중간값 1이 아니면
        print('gi 값은 $gi 입니다.');
        size = Random().nextInt(100) % 2 == 0 ? 1 : 2;
      }
      groupBox[gi].add(size); // 각 컬럼 리스트에 1씩 들어간다. 결국 groupBox[0] 에는 34개, groupBox[1]과 groupBox[2] 에는 33개
      groupIndex[gi] += size; // 각 리스트값에 사이즈를 더해주면 위에서 제일 작은 값을 찾을 거고
    }
    print('groupBox[0] 값은 $groupBox[0]');
    print('groupBox[1] 값은 $groupBox[1]');
    print('groupBox[2] 값은 $groupBox[2]');
    tabController =
        TabController(length: 5, vsync: this); // 잘봐라. 이런것도 놓쳤지? this..
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(   // AppBar 를 안쓰면서 AppBar 처럼 작업하면 상태표시줄을 넘어가기때문에 SafeArea 위젯을 사용한다.
      child: Column(
          children: [
            _myAppBarInColumn(),
            Expanded(child: _myBody()),
          ],
        ),
      ),
    );
  }


  List<Widget> _tabBarList() {
    return [
      const Padding(
        // 이렇게 Padding 을 넣으니깐 잘되는구나.
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Text(
          "인기",
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Text(
          "계정",
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Text(
          "오디오",
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Text(
          "태그",
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Text(
          "장소",
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
      ),
    ];
  }

  Widget _myBody() {
    // 컬럼이 3개가 있고.. 이미지를 하나씩 축적하면 어떨까?
    print("groupBox.length 의 값은 ${groupBox.length} 입니다.");
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
          List.generate(groupBox.length, (index) => Expanded(
            child: Column(children: // 총 3개의 확장된 컬럼이 들어가는거고..
              List.generate(groupBox[index].length, (jndex) => Container(
                height: Get.width * 0.33 * groupBox[index][jndex], // groupBox[index][jndex] 의 값은 1 이나 2 가 들어간다.
                decoration: BoxDecoration(border: Border.all(color: Colors.white),
                color: Colors.primaries[Random().nextInt(Colors.primaries.length)]),
                child: CachedNetworkImage(fit: BoxFit.cover,imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5W2qWDdF7ztjYI9lL_odxd3LY3uv8BOI9Ug&usqp=CAU'),
              )).toList(),
            ),
          ),
          ).toList(),
/*
        Expanded(
          child: Column(children: [
            Container(height: 140, color: Colors.blue,),
          ],),
        ),
        Expanded(
          child: Column(children: [
            Container(height: 140, color: Colors.grey,),
          ],),
        ),
*/
      ),
    );
  }

  Widget _myBodyOld() {
    // 여기서 잘봐라. TabBarView 를 사용한다.
    return Container(
      child: TabBarView(
        controller: tabController,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchScreenDetail()));
                //Navigator.pushNamed(context, "/SearchScreenDetail");
                //Get.toNamed("/SearchFocusDetail"); // 이렇게 하니깐 안된다.
              },
              child: Container(
                child: const Center(
                  child: Text('인기 페이지'),
                ),
              )),
          Container(
            child: const Center(
              child: Text('계정 페이지'),
            ),
          ),
          Container(
            child: const Center(
              child: Text('오디오 페이지'),
            ),
          ),
          Container(
            child: const Center(
              child: Text('태그 페이지'),
            ),
          ),
          Container(
            child: const Center(
              child: Text('장소 페이지'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _myAppBarInAppBar() {
    return AppBar( // 컬럼 안에도 AppBar 를 리턴할 수 있다는거지.. 잘 기억하자.
      title: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
          //color: const Color(0xffefefef), // 여기서 오류가 나고 있네..
          child: const TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '검색',
                contentPadding: EdgeInsets.only(left: 15, top: 7, bottom: 7),
                isDense: true),
          )),
      elevation: 0,
      leading: GestureDetector(
          onTap: () {
            //Navigator.maybePop(context);
            //Get.back();
          },
          child: const Icon(Icons.arrow_back)),
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(AppBar().preferredSize.height),
          child: Container(
            height: AppBar().preferredSize.height,
            width: Size.infinite.width,
            //color: Colors.white,
            decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Color(0xffe4e4e4)))),
            child: TabBar(
              controller: tabController,
              indicatorColor: Colors.black,
              tabs: _tabBarList(),
            ),
          )),
    );
  }
}

Widget _myAppBarInColumn() {
  return Row(
    children: [
      Expanded( // 왜 이런 위젯이 기억이 안냐냐고..
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          margin: EdgeInsets.only(left: 15),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: Color(0xffefefef)),
          child: Row(
            children:
              const [
                Icon(Icons.search),
                Text('검색', style: TextStyle(fontSize: 15, color: Color(0xff838383)),),
              ],
          ),
        ),
      ),
      const Padding(
        padding: EdgeInsets.all(15.0),
        child: Icon(Icons.location_pin),
      ),
    ],
  );
}