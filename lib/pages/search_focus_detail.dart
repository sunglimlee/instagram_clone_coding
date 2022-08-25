import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchFocusDetail extends StatelessWidget {
  const SearchFocusDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 역시 멍청해.. Navigator 전통방식 써놓고 Get.back 하고 있다... ㅉㅉㅉ
    return Center(child: GestureDetector(onTap: () => Navigator.pop(context),child: Container(child: const Text("Search Focus Detailsssss", style: TextStyle(color: Colors.purple),),)));
  }
}
