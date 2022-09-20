import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_coding/controller/upload_controller.dart';
import 'package:instagram_clone_coding/pages/upload.dart';
import 'package:instagram_clone_coding/widgets/etc.dart';
import 'package:instagram_clone_coding/widgets/message_popup.dart';

// 원래 enum 은 바깥으로 뺀다.
enum PageName { HOME, SEARCH, UPLOAD, ACTIVITY, MYPAGE }

class BottomNavController extends GetxController {
  static BottomNavController get to =>
      Get.find<BottomNavController>(); // 이렇게 하면 간단하게 찾는다.
  RxInt pageIndex = 0.obs;
  List<int> bottomHistory = [0]; // 히스토리를 이렇게 관리하는구나.

  void changeBottomNav(value, {bool isTapped = true}) {
    // 봐라. 파라미터 맞잖아!
    var page = PageName.values[value]; // QnADartGrammar
    switch (page) {
      // 아주 좋은 방법이다. 이런걸도 꿀팁
      case PageName.HOME:
      case PageName.SEARCH:
      case PageName.ACTIVITY:
      case PageName.MYPAGE:
        _changePage(value, isTapped: isTapped);
        break;
      case PageName.UPLOAD:
        Get.to(() => Upload(), binding: BindingsBuilder(() {
          Get.put(UploadController(), permanent: true);
        }));
        break;
    }
  }

  void _changePage(int value, {bool isTapped = true}) async {
    pageIndex.value = value;
    print('현재 페이지 인뎃의 값은 ${pageIndex.value} 입니다.');
    // 만약 search 페이지를 눌렀다면
    if (pageIndex.value == bottomHistory.last) {
      //BottomNavController.to.willPopActionByShowDialog();

      // 이부분이 search 버턴을 한번 더 누르면 팝이 되는 부분이다.
      // 여기부분부터 nested Navigation 부분의 willPop 부분이다. 꼭 필요한 부분이지..
      var page = PageName.values[bottomHistory.last];
      if (page == PageName.SEARCH) {
        // search 페이지 안이라면 그안에서 팝할게 있을지도 모르니깐..
        // https://stackoverflow.com/questions/49672706/flutter-navigation-pop-to-index-1
        var value = await Get.nestedKey(1)!
            .currentState!
            .maybePop(); // 여기 안에서 팝할게있으면 여기서 하고
        //if (value) return false;
        /*
        value 가 true 이면 이조건문을 빠져나가는데 그말을 팝할게 있었다는 거잖아. 말그대로 그리드뷰로 간다는거고
        value 가 false 이면 이제 팝할게 없다는 거고. 그래서 이조건문을 빠져나가지 못하고 다음문장을 계속실행한다.
         */
      }
    }
    if (!isTapped) return;
    // contain 과 remove 를 이용해서 4가지의 페이지만 보이도록 할 수도 있다. 근데 난 그건 맘에 안듬.
    if (value != bottomHistory.last) bottomHistory.add(value); // 리스트에 값을 추가하고
    print(bottomHistory);
  }

  Future<bool> willPopActionByShowDialog() async {
    if (bottomHistory.length == 1) {
      // [question] The argument type 'BuildContext?' can't be assigned to the parameter type 'BuildContext'.
      // [answer] Get.context!
      showDialog(
          context: Get.context!,
          builder: (context) {
            return MessagePopup(
              // 여기 잘보자. cancel Callback : Get.back 만 했다. 왜냐하면 함수가 넘어가야 하니깐.
              okCallback: () => exit(0),
              title: '시스템',
              message: '종료하시겠습니까?',
              cancelCallback: Get.back,
            );
          });
      return true;
    } else {
      // 여기부분부터 nested Navigation 부분의 willPop 부분이다. 꼭 필요한 부분이지..
      var page = PageName.values[bottomHistory.last];
      if (page == PageName.SEARCH) {
        // search 페이지 안이라면 그안에서 팝할게 있을지도 모르니깐..
        // https://stackoverflow.com/questions/49672706/flutter-navigation-pop-to-index-1
        var value = await Get.nestedKey(1)!
            .currentState!
            .maybePop(); // 여기 안에서 팝할게있으면 여기서 하고
        if (value) return false;
        /*
        value 가 true 이면 이조건문을 빠져나가는데 그말을 팝할게 있었다는 거잖아. 말그대로 그리드뷰로 간다는거고
        value 가 false 이면 이제 팝할게 없다는 거고. 그래서 이조건문을 빠져나가지 못하고 다음문장을 계속실행한다.
         */
      }
      bottomHistory.removeLast();
      var index = bottomHistory.last;
      changeBottomNav(index, isTapped: false);
      return false;
    }
  }

  Future<bool> willPopActionByGetDefaultDialog() async {
    //https://stackoverflow.com/questions/45109557/flutter-how-to-programmatically-exit-the-app
    if (bottomHistory.length == 1) {
      if (Platform.isAndroid || Platform.isIOS) {
        Get.defaultDialog(
            title: 'close',
            content: Text('Do you want to close?'),
            textConfirm: "Close",
            textCancel: "Cancel",
            onConfirm: () {
              if (Platform.isAndroid) {
                SystemNavigator.pop();
              } else if (Platform.isIOS) {
                exit(
                    0); // or use pub.dev/packages/minimize_app   MinimizeApp.minimizeApp();
              }
            },
            onCancel: () => Get.back());
        return true;
      } else {
        return false;
      }
    } else {
      print('goto before page!'); // 현재는 아무것도 움직이지 않잖아????
      bottomHistory.removeLast(); // 마지막걸 지우고..
      print(bottomHistory);
      var index = bottomHistory.last;
      changeBottomNav(index,
          isTapped: false); // 여기 보이나? 탭으로 바꿔주고 있다는 걸... 결국 이게 맞네.. 내가 한게 맞았네..
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
