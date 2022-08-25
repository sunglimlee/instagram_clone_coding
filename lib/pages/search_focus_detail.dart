import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchFocusDetail extends StatelessWidget {
  const SearchFocusDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: GestureDetector(onTap: () => Get.back(),child: Container(child: const Text("Search Focus Detailsssss", style: TextStyle(color: Colors.purple),),)));
  }
}
