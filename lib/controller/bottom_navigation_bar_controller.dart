import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_coding/wigets/etc.dart';

class BottomNavigationBarController extends GetxController {
  static BottomNavigationBarController get to =>
      Get.find(); // 이제 BottomNavigationBarController.to 로 사용할 수 있지..
  GlobalKey<NavigatorState> searchFocusNavigationKey = GlobalKey<
      NavigatorState>();
  GlobalKey<NavigatorState> IndexedStackKey = GlobalKey<
      NavigatorState>();
  Rx<BottomNavigationNames> _rxTabIndex = BottomNavigationNames.HOME.obs;

  Rx<BottomNavigationNames> get rxTabIndex => _rxTabIndex;

  set rxTabIndex(Rx<BottomNavigationNames> value) {
    _rxTabIndex = value;
  }
  // 야! onWillPop() 이 괄호 안넣었다고 문제 되는거봐라..
  Future<bool> onWillPop() async {
  return !await searchFocusNavigationKey.currentState!.maybePop();

  }

  void back() {
    //setCategoryPage(false);
    onWillPop();
  }
}