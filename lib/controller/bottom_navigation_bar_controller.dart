import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_coding/wigets/etc.dart';

class BottomNavigationBarController extends GetxController {
  GlobalKey<NavigatorState> searchFocusNavigationKey = GlobalKey<NavigatorState>();
  Rx<BottomNavigationNames> _rxTabIndex = BottomNavigationNames.HOME.obs;

  Rx<BottomNavigationNames> get rxTabIndex => _rxTabIndex;

  set rxTabIndex(Rx<BottomNavigationNames> value) {
    _rxTabIndex = value;
  }

}