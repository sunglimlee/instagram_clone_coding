import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_coding/controller/bottom_nav_controller.dart';
import 'package:instagram_clone_coding/pages/active_history.dart';
import 'package:instagram_clone_coding/pages/home_screen.dart';
import 'package:instagram_clone_coding/pages/mypage.dart';
import 'package:instagram_clone_coding/pages/search_screen.dart';
import 'package:instagram_clone_coding/widgets/image_data.dart';
import 'package:instagram_clone_coding/controller/bottom_nav_controller.dart';

class App extends GetView<BottomNavController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // [question] The argument type 'Future<bool>' can't be assigned to the parameter type 'Future<bool> Function()?'.
      // [answer] controller.willPopActionByShowDialog not controller.willPopActionByShowDialog()
        onWillPop: controller.willPopActionByShowDialog,
        child: Obx(() => Scaffold(
            //appBar: myAppBar(),
            body: myBody(),
            bottomNavigationBar: myBottomNavigationBar(),
          ),
        ));
  }

  PreferredSizeWidget myAppBar() {
    return AppBar();
  }

  Widget myBody() {
    return IndexedStack(
      index: controller.pageIndex.value,
      children: [
        const HomeScreen(),
        _nestedNavigationForSearchFocus(),
        Container(), // Bottom 의 Index 랑 매칭이 되기 때문에 더미를 넣은것const 일뿐
        const ActiveHistory(),
        const MyPage(),
      ],
    );
  }
  Widget _nestedNavigationForSearchFocus() {
    return Navigator(
      key: Get.nestedKey(1),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/SearchFocus') {
          return GetPageRoute(
            page: () => SearchScreen(),
          );
        } else {
          return GetPageRoute(page: () => SearchScreen());
        }
      },
    );
  }

  Widget myBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: controller.pageIndex.value,
      onTap: (value) { //print('onTap: $value');
        controller.changeBottomNav(value);},
      items: [
        BottomNavigationBarItem(
            icon: ImageData(icon: IconsPath.homeOff),
            activeIcon: ImageData(icon: IconsPath.homeOn),
            label: 'home'),
        BottomNavigationBarItem(
            icon: ImageData(icon: IconsPath.searchOff),
            activeIcon: ImageData(icon: IconsPath.searchOn),
            label: 'search'),
        BottomNavigationBarItem(
            icon: ImageData(icon: IconsPath.uploadIcon),
            label: 'upload'),
        BottomNavigationBarItem(
            icon: ImageData(icon: IconsPath.activeOff),
            activeIcon: ImageData(icon: IconsPath.activeOn),
            label: 'active'),
        BottomNavigationBarItem(
            icon: Container(
              width: 30, height: 30, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.grey,),
            ),
            label: 'user'),
      ],
    );
  }
}

