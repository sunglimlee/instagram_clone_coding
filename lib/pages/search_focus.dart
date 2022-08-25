import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_coding/pages/search_focus_detail.dart';

// 왜 StatefulWidget 을 만들었을까?
class SearchFocus extends StatefulWidget {
  const SearchFocus({Key? key}) : super(key: key);

  @override
  State<SearchFocus> createState() => _SearchFocusState();
}

class _SearchFocusState extends State<SearchFocus> with TickerProviderStateMixin {
  // 여기에다가 tabController 를 만드는 구나.
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this); // 잘봐라. 이런것도 놓쳤지? this..
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
            // color: Color(0xffefefef), // 여기서 오류가 나고 있네..
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
              Get.back();
            },
            child: const Icon(Icons.arrow_back)),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(AppBar().preferredSize.height),
            child: Container(
              height: AppBar().preferredSize.height,
              width: Size.infinite.width,
              //color: Colors.white,
              decoration: const BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: Color(0xffe4e4e4)))),
              child: TabBar(controller: tabController,
                indicatorColor: Colors.black,
                tabs:
                  tabBarList()
                ,
              ),
            )),
      ),
      body: scaffoldBody(),
    );
  }

  List<Widget> tabBarList() {
    return [
      const Padding( // 이렇게 Padding 을 넣으니깐 잘되는구나.
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Text("인기", style: TextStyle(fontSize: 15, color: Colors.black),),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Text("계정", style: TextStyle(fontSize: 15, color: Colors.black),),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Text("오디오", style: TextStyle(fontSize: 15, color: Colors.black),),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Text("태그", style: TextStyle(fontSize: 15, color: Colors.black),),
      ),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Text("장소", style: TextStyle(fontSize: 15, color: Colors.black),),
      ),

    ];
  }

  Widget scaffoldBody() {
    // 여기서 잘봐라. TabBarView 를 사용한다.
    return Container(
      child: TabBarView(
        controller: tabController,
        children: [
          GestureDetector(onTap:() {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchFocusDetail()));
          },
              child: Container(child: const Center(child: Text('인기 페이지'),),)),
          Container(child: const Center(child: Text('계정 페이지'),),),
          Container(child: const Center(child: Text('오디오 페이지'),),),
          Container(child: const Center(child: Text('태그 페이지'),),),
          Container(child: const Center(child: Text('장소 페이지'),),),
        ],
      ),
    );
  }
}
