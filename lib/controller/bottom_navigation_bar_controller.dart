import 'package:get/get.dart';
import 'package:instagram_clone_coding/wigets/etc.dart';

class BottomNavigationBarController extends GetxController {
  Rx<BottomNavigationNames> _rxTabIndex = BottomNavigationNames.HOME.obs;

  Rx<BottomNavigationNames> get rxTabIndex => _rxTabIndex;

  set rxTabIndex(Rx<BottomNavigationNames> value) {
    _rxTabIndex = value;
  }

}