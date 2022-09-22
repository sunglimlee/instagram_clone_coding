import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_coding/controller/auth_controller.dart';
import 'package:instagram_clone_coding/controller/home_controller.dart';
import 'package:instagram_clone_coding/model/post.dart';
import 'package:instagram_clone_coding/pages/upload/upload_description.dart';
import 'package:instagram_clone_coding/src/repository/post_repository.dart';
import 'package:instagram_clone_coding/utils/data_util.dart';
import 'package:instagram_clone_coding/widgets/message_popup.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:path/path.dart';
import 'package:photofilters/photofilters.dart';
import 'package:image/image.dart' as imageLib;

class UploadController extends GetxController {
  // [question] Rx 값을 다루는데 문제가 될때
  // [answer] https://chornthorn.github.io/getx-docs/state-management/reactive-state-manager/index
  //var _selectedImage = const AssetEntity(id: 'temp', typeInt: 1, width: 100, height: 100).obs; // 실제로 개남은 이렇게 했지
  //var _selectedImage = AssetEntity(id: 1.toString(), typeInt: 0, width: 100, height: 100).obs;
  //AssetEntity? _selectedImage = null.obs as AssetEntity?;
  Rx<AssetEntity?> selectedImage = (null as AssetEntity?).obs;
  var headerTitle = ''.obs;
  var imageList = <AssetEntity>[].obs;
  File? filteredImage; // 여기봐라. late 로 하지 않고 null 이 될 수 있다고 하고 있다.
  Post? post; // 새게시물 업로드를 위한 Model 객체

  // 앨범의 리스트는 누르는순간 builder 를 통해서 새롭게 만들고 그때 이민 이 album 이 정해져 있기 때문에
  List<AssetPathEntity> _albums =
      <AssetPathEntity>[]; // 이건 obs 를 이욯해 상태관리를 할 필요가 없다는것

  TextEditingController textEditingController =
      TextEditingController(); // 새게시물 description 관련

  // 지금 이게 필요는 없다. 나중에 이게 여러군데서 쓰일때 사용하면 좋은거지 Upload 객체 페이지 하나에서 사용하는데 의미가 거의 없지.
  //static UploadController get to => Get.find<UploadController>(); // to 로 언제든지 찾을 수 있도록 하고

/*
  get selectedImage => _selectedImage;
  // 다해간다. 조금만 더 집중하도록 하자.
  set selectedImage(value) {
    // value 값은 AssetEntity 인데 어떻게 하면 Rx<AssetEntity> 로 넣을 수 있나?
    print('value 의 값은 ${value.toString()}');
    _selectedImage = value; // 여기 보는것 처럼 들어오는 value 값을 Rx 형에다가 대입하고 있다.
    //_selectedImage?.update((val) {val.id = value.id;});
  }
*/

/*
  get imageList => _imageList;
  set imageList(value) {
    _imageList = value;
  }
*/

  List<AssetPathEntity> get albums =>
      _albums; // get 과 set 을 통해서 _albums 의 내용을 그대로 다루고 있다는 것.
  set albums(List<AssetPathEntity> value) {
    _albums = value;
  }

  @override
  void onInit() {
    // 컨트롤러가 put 이되면서 객체가 생성될 때 이부분을 통해서 사진이 로드가 된다.
    super.onInit();
    loadPhoto();
    post = Post.init(AuthController.to.user.value);
  }

  void loadPhoto() async {
    // 비동기화로 진행하고
    var result = await PhotoManager
        .requestPermissionExtend(); // PermissionState will be returned. // 퍼미션 받을 때 까지 기다려서 다음줄로 넘어가고
    if (result.isAuth) {
      // 퍼미션이 허락되었으면
      albums = await PhotoManager.getAssetPathList(
          // 포토메니져를 이용해서 리스트를 받아와서 기다리고
          type: RequestType.image, // 이미지 타입이고
          filterOption: FilterOptionGroup(
              imageOption: const FilterOption(
                  sizeConstraint:
                      SizeConstraint(minHeight: 100, minWidth: 100)),
              // 사이즈 제약조건을 주고
              orders: [
                const OrderOption(
                  // 정렬방식을 정하고
                  type: OrderOptionType.createDate,
                  asc: false,
                ), // 최신이미지 먼저본다.
              ]));
      loadData(); // albums 리스트 값이 다 들어오고 나면 _loadData 를 실행하기 시작해라는 뜻
    } else {
      // message 나 권한 요청
    }
  }

  void loadData({int whichAlbums = 0}) async {
    // 이것도 비동기로
    print(' 값은 ${albums.first.name}');
    // [question] Unhandled Exception: type 'String' is not a subtype of type 'RxString' in type cast
    // [answer] 괄호로 넣어주니깐 되었다.
    headerTitle(albums[whichAlbums].name); // headerTitle 변경하고
    await _pagingPhotos(whichAlbums: whichAlbums);
    //update();
  }

  // 변경된 이미지에 맞추서 이미지리스트를 새로 만드는 부분.
  // 추후 이 imageList 를 이용해서 리스트를 화면에 뿌려주게 된다.
  Future<void> _pagingPhotos({int whichAlbums = 0}) async {
    imageList.clear();
    var photos = await albums[whichAlbums].getAssetListPaged(page: 0, size: 30);
    imageList.addAll(photos); // 이부분이 리스트르 위한 변수
    selectedImage.value = imageList.first; // 이부분이 프리뷰 이미지를 위한 변수,
  }

  void gotoImageFilter() async {
    // 이미지 필터 처리하는 부분
    // file 이 future 로 감싸져 있기때문에 먼저 file 을 빼내고 나서
    var file = await selectedImage.value!.file;
    var fileName = basename(file!.path);
    var image = imageLib.decodeImage(file.readAsBytesSync());
    image = imageLib.copyResize(image!, width: 1000);
    var imageFile = await Navigator.push(
      Get.context!,
      MaterialPageRoute(
        builder: (context) => PhotoFilterSelector(
          title: const Text("Photo Filter Example"),
          image: image!,
          filters: presetFiltersList,
          filename: fileName,
          loader: const Center(child: CircularProgressIndicator()),
          fit: BoxFit.contain,
        ),
      ),
    );
    // 여기서 궁금한게 필터가 적용되어 이미지 자체가 변경이 된다는 건가?
    // 필터가 되어진 파일을 추출한다.?
    if (imageFile != null && imageFile.containsKey('image_filtered')) {
      filteredImage = imageFile['image_filtered'];
      Get.to(() => const UploadDescription());
    }
  }

  void unFocusKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void uploadPost() {
    unFocusKeyboard();
    print(textEditingController.text);
    // extiension 포함된 아무이름을 uuid 로 생성시켜서 만듦
    // path 의 basename 을 사용하니 무지하게 좋네.
    String filename = DataUtil.makeFilePath(basename(filteredImage!.path));
    // uid 디렉토리 밑에다가 저장하는 걸로 한다.
    UploadTask task = uploadXFile(
        filteredImage!, '/${AuthController.to.user.value.uid}/$filename');
    if (task != null) {
      task.snapshotEvents.listen((event) async {
        if (event.bytesTransferred == event.totalBytes &&
            event.state == TaskState.success) {
          // 완료된 시점에서는 ref 를 통해서 다운로드 URL 을 알 수 있다.
          var downloadUrl = await event.ref.getDownloadURL();
          var updatedPost = post!.copyWith(
              thumbnail: downloadUrl, description: textEditingController.text);
          _submitPost(updatedPost);
        }
      });
    }
  }

  UploadTask uploadXFile(File file, String filename) {
    // 실제로 FireStore 에 저장하는 부분
    var f = File(file.path);
    var ref = FirebaseStorage.instance.ref().child('instagram').child(filename);
    final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});
    return ref.putFile(f, metadata);
  }

  // 여기에서 fireStore 에 업데이트를 해주는거다.
  void _submitPost(Post updatedPost) async {
    await PostRepository.updatePost(updatedPost);
    showDialog(
        context: Get.context!,
        builder: (_) => MessagePopup(
              title: '포스트',
              message: '포스팅이 완료되었습니다.',
              okCallback: () {
                Get.until((route) => Get.currentRoute == '/'); //맨처음으로 보내라.
                Get.find<HomeController>().loadFeedList();
                textEditingController.text = '';
              },
              cancelCallback: () {
                Get.back();
              },
            ));
  }
}
