import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_coding/controller/bottom_navigation_bar_controller.dart';
import 'package:instagram_clone_coding/pages/search_focus.dart';
import 'package:instagram_clone_coding/wigets/etc.dart';

class SearchScreen extends StatelessWidget {
  BottomNavigationBarController bottomNavigationBarController = Get.find<BottomNavigationBarController>();
  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: GestureDetector(onTap: () {
        //Get.to(SearchFocus());
        //Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchFocus()));
        bottomNavigationBarController.rxTabIndex(BottomNavigationNames.ITEM);

      },
          child: Text("Search Screen")),
    ));
  }
}
