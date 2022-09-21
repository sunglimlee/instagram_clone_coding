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
            onTap:
              // 데이터 저장하고 불러오는기능 구현, FireStore, FirebaseStorage,
              // 데이터를 접근하는 리파지토리부분을 선정해야 하고,
              // GetX 로 컨트롤러 만들어서 작업하든 Simple 하게 GetBuilder 넣어서 작업하든지..
              controller.uploadPost,
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
              // 현재 body 를 이용해서 GestureDetector 를 감쌌기 때문에 body 안을 눌러야 없어진다.
              //FocusManager.instance.primaryFocus?.unfocus();
              controller.unFocusKeyboard();
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch, // 넓이를 전체 사용한다.
                children: [
                  _description(),
                  line,
                  _infoOnt('사람태그하기'),
                  line,
                  _infoOnt('위치 추가'),
                  line,
                  _infoOnt('다른 미디어에도 게시 '),
                  line,
                  snsInfo(),
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
        Expanded(
            child: TextField(
              controller: controller.textEditingController,
          maxLines: null,
          decoration: const InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 15),
            hintText: '문구 입력...',
          ),
        ))
      ],
    );
  }

  // 이건 알고보니 그냥 getter, setter 잖아. 그냥 이렇게 사용할 수도 있구나.
  Widget get line => const Divider(
        color: Colors.grey,
        thickness: 1,
      );

  Widget _infoOnt(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 17),
      ),
    );
  }

  Widget snsInfo() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Facebook',
                style: TextStyle(fontSize: 17),
              ),
              Switch(value: false, onChanged: (bool value) {})
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Twitter',
                style: TextStyle(fontSize: 17),
              ),
              Switch(value: false, onChanged: (bool value) {})
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Tumblr',
                style: TextStyle(fontSize: 17),
              ),
              Switch(value: true, onChanged: (bool value) {})
            ],
          ),
        ],
      ),
    );
  }
}
