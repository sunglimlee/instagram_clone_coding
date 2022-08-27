import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_coding/controller/bottom_nav_controller.dart';
import 'package:instagram_clone_coding/src/components/image_data.dart';
import 'package:instagram_clone_coding/controller/bottom_nav_controller.dart';

class App extends GetView<BottomNavController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: controller.willPopAction,
        child: Obx(() => Scaffold(
            appBar: myAppBar(),
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
        Container(child: Center(child: Text('HOME'),),),
        Container(child: Center(child: Text('SEARCH'),),),
        Container(child: Center(child: Text('UPLOAD'),),),
        Container(child: Center(child: Text('ACTIVITY'),),),
        Container(child: Center(child: Text('MYPAGE'),),),
      ],
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
