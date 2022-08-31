import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_coding/controller/bottom_nav_controller.dart';
import 'package:instagram_clone_coding/pages/search_screen.dart';
import 'package:instagram_clone_coding/pages/search_screen_detail.dart';
import 'package:instagram_clone_coding/pages/search_screen_detail_old.dart';
import 'package:instagram_clone_coding/wigets/etc.dart';

class SearchScreenOld extends StatelessWidget {
  BottomNavController bottomNavigationBarController = Get.find<BottomNavController>();
  SearchScreenOld({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: GestureDetector(onTap: () {
        //Get.to(SearchFocus());
        Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchScreenDetailOld()));
        //bottomNavigationBarController.rxTabIndex(BottomNavigationNames.ITEM);

      },
          child: Text("Search Screen")),
    ));
  }
}
