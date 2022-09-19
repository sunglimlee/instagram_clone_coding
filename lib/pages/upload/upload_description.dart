import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_coding/controller/upload_controller.dart';
import 'package:instagram_clone_coding/widgets/image_data.dart';

class UploadDescription extends GetView<UploadController> {
  const UploadDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[100],
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: Get.back,
          // 이런 디테일... 파라미터없는 보이드 함수 를 그래도 이름으로 대입하고 있잖아.. 이런 디테일 좋네.
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ImageData(
              icon: IconsPath.backBtnIcon,
              width: 50,
            ),
          ),
        ),
        title: const Text(
          '새 게시물',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: ImageData(
                icon: IconsPath.uploadComplete,
              ),
            ),
          )
        ],
      ),
      body: Stack(children: [
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          child: GestureDetector(
            onTap: () {
              // 현재 body 를 이용해서 GetstureDetector 를 감쌌기 때문에 body 안을 눌러야 없어진다.
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: SingleChildScrollView(
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.stretch, // 항상 헷갈려
                children: [
                  _description(),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  _description() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            width: 60,
            height: 60,
            child: Image.file(
              controller.filteredImage!,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Expanded(
            child: TextField(
          maxLines: null,
        ))
      ],
    );
  }
}
