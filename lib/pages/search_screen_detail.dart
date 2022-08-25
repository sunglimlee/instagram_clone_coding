import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreenDetail extends StatelessWidget {
  const SearchScreenDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: GestureDetector(onTap: () => Get.back(),child: Container(child: const Text("Search Screen Details", style: TextStyle(color: Colors.red),),)));
  }
}
