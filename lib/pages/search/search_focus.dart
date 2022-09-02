import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_coding/controller/bottom_nav_controller.dart';
import 'package:instagram_clone_coding/widgets/image_data.dart';

class SearchFocus extends StatefulWidget {
  const SearchFocus({Key? key}) : super(key: key);

  @override
  State<SearchFocus> createState() => _SearchFocusState();
}

class _SearchFocusState extends State<SearchFocus>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 5,
      vsync: this,
    ); // vsync 를 이용해서 인터페이스를 찾는다.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _myAppBar(), // 상단이 고정이기 때문에 기존 AppBar 를 사용하자.
      body: _body(),
    );
  }

  PreferredSizeWidget _myAppBar() {
    return AppBar(
      titleSpacing: 0,
      // 이런것도 있네.. 타이틀의 스페이스가 기본으로 정해져 있는게 있구나.
      elevation: 0,
      leading: GestureDetector(
        onTap:
          BottomNavController.to.willPopActionByShowDialog,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ImageData(
            icon: IconsPath.backBtnIcon,
          ),
        ),
      ),
      title: Container(
        margin: EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Color(0xffefefef),
        ),
        child: const TextField(
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '검색',
              contentPadding: EdgeInsets.only(left: 15, top: 7, bottom: 7),
              isDense: true),
        ),
      ),
      bottom: _myAppBarBottom(),
    );
  }

  PreferredSizeWidget _myAppBarBottom() {
    print('Size.fromHeight(AppBar().preferredSize.height) 의 값은 ${Size.fromHeight(AppBar().preferredSize.height)} 입니다.');
    return PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: Container( //color: Colors.blue,
          //height: AppBar().preferredSize.height,
            decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xffe4e4e4)))),
            width: Size.infinite.width,
            // 사이즈 객체의 static 변수 infinite 를 이용해서 Size 객체를 무조건 하나 생성하고 그 width 를 받는다.
            child: TabBar(
              indicatorColor: Colors.black,
              controller: tabController,
              tabs: [
                _tabMenuOne('인기'),
                _tabMenuOne('계정'),
                _tabMenuOne('오디오'),
                _tabMenuOne('테그'),
                _tabMenuOne('장소'),
              ],
            )));
  }
  Widget _tabMenuOne(String menu) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Text(
        menu,
        style: const TextStyle(fontSize: 15, color: Colors.black),
      ),
    );
  }

  Widget _body() {
    return Container(color: Colors.red,child:
      TabBarView(controller: tabController, children: const [
        Center(child: Text('인기페이지'),),
        Center(child: Text('계정페이지'),),
        Center(child: Text('오디오페이지'),),
        Center(child: Text('테그페이지'),),
        Center(child: Text('장소페이지'),),
      ],),);
    }
}
