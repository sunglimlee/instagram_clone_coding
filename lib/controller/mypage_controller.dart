import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_coding/controller/auth_controller.dart';
import 'package:instagram_clone_coding/model/instagram_user.dart';

class MyPageController extends GetxController with GetTickerProviderStateMixin {
  late TabController tabController;
  Rx<InstagramUser> targetUser = InstagramUser().obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  void _loadData() {
    setTargetUser();

    // 포스트 리스트 로드
    // 사용자 정보 로드
  }

  void setTargetUser() {
    var uid = Get.parameters['targetUid'];
    if (uid == null) {
      targetUser(AuthController.to.user.value); // 타겟 uid 받아와서 TargetUser 에다가 넣어주었다.
    } else {
      // TODO 상대 uid 로 users collection 을 조회해서 그걸 targetUser 에 담아주면 된다.
    }
  }
}