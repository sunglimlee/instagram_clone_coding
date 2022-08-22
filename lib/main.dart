import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_coding/controller/bottom_navigation_bar_controller.dart';
import 'package:instagram_clone_coding/pages/about_screen.dart';
import 'package:instagram_clone_coding/pages/home_screen.dart';
import 'package:instagram_clone_coding/pages/item_screen.dart';
import 'package:instagram_clone_coding/pages/like_screen.dart';
import 'package:instagram_clone_coding/pages/search_screen.dart';
import 'package:instagram_clone_coding/wigets/etc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(BottomNavigationBarController()); // 이게 어디에 들어가야 하는건가? 여기 맞나? 왜 Bindings 객체 상속받은건 안되지?
     return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  var bottomNavigationBarController = Get.find<BottomNavigationBarController>();

  @override
  Widget build(BuildContext context) {
    print(" 이것도 계속 바뀌나?"); // 아니 안바뀐다. 이렇게 작업하면 일단은 문제가 없다.
    return Obx(() => // Obx 가 위에 이렇게 있어야 하고.
       Scaffold(
        appBar: AppBar(),
        bottomNavigationBar:
          BottomNavigationBar(
            onTap: (index) {
              print("BottomNavigationNames.values[index] 는 ${BottomNavigationNames.values[index]} 입니다요. ");
              bottomNavigationBarController.rxTabIndex(BottomNavigationNames.values[index]);},
            currentIndex: currentIndex(), // 값을 불러와야 하는데.
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            items: bottomNavigationBarItemList(),
          ),
         body: currentBody(), // 뭐! 모든게 문제네.. body 하나하는데도 이렇게 시간이 걸린다니.. // 이거 만들때마다 바뀌게 될까?
      ),
    );
  }
  int currentIndex() {
    print("controller.rxTabIndex.value.index 는 ${bottomNavigationBarController.rxTabIndex.value.index} 입니다. ");
    return bottomNavigationBarController.rxTabIndex.value.index; // enum 에서 index 값을 이용해서 BottomNavigationBar 를 Navigation 하고 있다.
  }

  Widget currentBody() { // static 으로 만드니깐 더이상 안바뀐다.
    switch (bottomNavigationBarController.rxTabIndex.value) {
      case BottomNavigationNames.HOME : {
        var home = MyScreens.homeScreen;
        print("HomeScreen 의 HashCode 는 ${home.hashCode} 입니다.");
        return home;}
      case BottomNavigationNames.SEARCH : { return MyScreens.searchScreen;}
      case BottomNavigationNames.ITEM : { return MyScreens.itemScreen;}
      case BottomNavigationNames.LIKE : { return MyScreens.likeScreen;}
      case BottomNavigationNames.ABOUT : { return MyScreens.aboutScreen;}
  }
  }
}


List<BottomNavigationBarItem> bottomNavigationBarItemList() {
  List<BottomNavigationBarItem> bottomNavigationBarItem = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.add,
        color: Colors.purple[500],
      ),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.add,
        color: Colors.purple[500],
      ),
      label: "Search",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.add,
        color: Colors.purple[500],
      ),
      label: "Item",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.add,
        color: Colors.purple[500],
      ),
      label: "Like",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.add,
        color: Colors.purple[500],
      ),
      label: "About",
    ),
  ];
  return bottomNavigationBarItem;
}
