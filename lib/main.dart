import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_coding/controller/bottom_navigation_bar_controller.dart';
import 'package:instagram_clone_coding/pages/about_screen.dart';
import 'package:instagram_clone_coding/pages/home_screen.dart';
import 'package:instagram_clone_coding/pages/like_screen.dart';
import 'package:instagram_clone_coding/pages/search_focus.dart';
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
    Get.put(
        BottomNavigationBarController()); // 이게 어디에 들어가야 하는건가? 여기 맞나? 왜 Bindings 객체 상속받은건 안되지?
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
    return Obx(
      () => // Obx 가 위에 이렇게 있어야 하고.
          Scaffold(
/*
        appBar: AppBar(
          title: Text(
              bottomNavigationBarController.rxTabIndex.value.name.toString()),
*/
/*
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Get.back(),),
*//*

        ),
*/
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index)=> bottomNavigationBarOnTap(context, index),
          currentIndex: currentIndex(),
          // 값을 불러와야 하는데.
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          items: bottomNavigationBarItemList(),
        ),
        body: IndexedStack(index: bottomNavigationBarController.rxTabIndex.value.index,
        children: [
          Container(child: const HomeScreen(),),
          Container(child: SearchScreen(),),
          Container(child:
            Navigator( // 지금 이건 Navigator 가 감싸준거잖아...
              key: bottomNavigationBarController.searchFocusNavigationKey,
              onGenerateRoute: (routeSettings) {
                return MaterialPageRoute(builder: (context) {
                  return const SearchFocus();
                });
              },
            ),
            ),
          Container(child: const LikeScreen()),
          Container(child: const AboutScreen(),),
        ],), // 뭐! 모든게 문제네.. body 하나하는데도 이렇게 시간이 걸린다니.. // 이거 만들때마다 바뀌게 될까?
      ),
    );
  }

  int currentIndex() {
    print(
        "controller.rxTabIndex.value.index 는 ${bottomNavigationBarController.rxTabIndex.value.index} 입니다. ");
    return bottomNavigationBarController.rxTabIndex.value
        .index; // enum 에서 index 값을 이용해서 BottomNavigationBar 를 Navigation 하고 있다.
  }

  Widget currentBody() {
    // static 으로 만드니깐 더이상 안바뀐다.
    switch (bottomNavigationBarController.rxTabIndex.value) {
      case BottomNavigationNames.HOME:
        {
          var home = MyScreens.homeScreen;
          print("HomeScreen 의 HashCode 는 ${home.hashCode} 입니다.");
          return home;
        }
      case BottomNavigationNames.SEARCH:
        {
          return MyScreens.searchScreen;
        }
      case BottomNavigationNames.ITEM:
        {
            return MyScreens.searchFocus;
            // 실컷 작업했는데 결국은 static 으로 만드니깐 아무문제 없이 계속 유지가 된다.
/*
            return Navigator( // 여기를 감싸주어서 이게 계속 유지가 되고 있는거네..
              key: bottomNavigationBarController.searchFocusNavigationKey,
              // 여기서 잘봐라. 여기 키를 이용해서 navigate 를 할 때는 무조건 searchFocus 로 간다는 거다.
              // 뭐가 잘못된거지????
              onGenerateRoute: (routeSetting) {
                return MaterialPageRoute(builder: (context) {
                  return MyScreens.searchFocus;
                });
              },
            );
*/

        }
      case BottomNavigationNames.LIKE:
        {
          return MyScreens.likeScreen;
        }
      case BottomNavigationNames.ABOUT:
        {
          return MyScreens.aboutScreen;
        }
    }
  }

  bottomNavigationBarOnTap(BuildContext context, int index) {
    //print("BottomNavigationNames.values[index] 는 ${BottomNavigationNames.values[index]} 입니다요. ");
    switch (index) {
/*
      case 8 : {
        // Get.to(SearchFocus());
        Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchFocus()));
        break;
      }
*/
      default : {

      }
    }
    bottomNavigationBarController
        .rxTabIndex(BottomNavigationNames.values[index]);

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
