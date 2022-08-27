import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_coding/pages/upload.dart';
import 'package:instagram_clone_coding/wigets/etc.dart';

// 원래 enum 은 바깥으로 뺀다.
enum PageName { HOME, SEARCH, UPLOAD, ACTIVITY, MYPAGE}

class BottomNavController extends GetxController {
  RxInt pageIndex = 0.obs;
  List<int> bottomHistory = [0]; // 히스토리를 이렇게 관리하는구나.

  void changeBottomNav(value, {bool isTapped = true}) { // 봐라. 파라미터 맞잖아!
    var page = PageName.values[value];
    switch (page) { // 아주 좋은 방법이다. 이런걸도 꿀팁
      case PageName.HOME:
      case PageName.SEARCH:
      case PageName.ACTIVITY:
      case PageName.MYPAGE:
        _changePage(value, isTapped: isTapped);
        break;
      case PageName.UPLOAD:
        Get.to(()=> const Upload());
        break;
    }
  }

  void _changePage(int value, {bool isTapped = true}) {
    pageIndex.value = value;
    if (!isTapped) return;
    // contain 과 remove 를 이용해서 4가지의 페이지만 보이도록 할 수도 있다. 근데 난 그건 맘에 안듬.
    if (value != bottomHistory.last) bottomHistory.add(value); // 리스트에 값을 추가하고
    print(bottomHistory);
  }

  Future<bool> willPopAction() async {
    if (bottomHistory.length == 1) {
      Get.defaultDialog(title: 'close', content: Text('Do you want to close?'),  textConfirm: "Close", textCancel: "Cancel",
      onConfirm: ()=> exit(0), onCancel: ()=> Get.back());
      return true;
    } else {
      print('goto before page!'); // 현재는 아무것도 움직이지 않잖아????
      bottomHistory.removeLast(); // 마지막걸 지우고..
      print(bottomHistory);
      var index = bottomHistory.last;
      changeBottomNav(index, isTapped: false); // 여기 보이나? 탭으로 바꿔주고 있다는 걸... 결국 이게 맞네.. 내가 한게 맞았네..
      return false;
    }
  }






/*

  static BottomNavController get to =>
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
*/

}