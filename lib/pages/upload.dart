import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:instagram_clone_coding/widgets/image_data.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_coding/controller/upload_controller.dart';

// var albums = <AssetPathEntity>[]; // 이거 똑같은 뜻인거 맞지? 확실하지?
class Upload extends StatelessWidget {
  const Upload({Key? key}) : super(key: key);

/*
  AssetEntity? selectedImage;
  var imageList = <AssetEntity>[];
  List<AssetPathEntity> albums = [];
*/

/*
  var headerTitle = '';
*/

/*
  @override
  void initState() {
    _loadPhoto();
  }
*/

/*
  void _loadPhoto() async {
    var result = await PhotoManager
        .requestPermissionExtend(); // PermissionState will be returned.
    if (result.isAuth) {
      albums = await PhotoManager.getAssetPathList(
          type: RequestType.image,
          filterOption: FilterOptionGroup(
              imageOption: const FilterOption(
                  sizeConstraint:
                      SizeConstraint(minHeight: 100, minWidth: 100)),
              orders: [
                const OrderOption(
                  type: OrderOptionType.createDate,
                  asc: false,
                ), // 최신이미지 먼저본다.
              ]));
      _loadData();
    } else {
      // message 나 권한 요청
    }
  }

  void _loadData() async {
    print(' 값은 ${albums.first.name}');
    headerTitle = albums.first.name;
    await _pagingPhotos();
    update();
  }

  Future<void> _pagingPhotos() async {
    var photos = await albums.first.getAssetListPaged(page: 0, size: 30);
    imageList.addAll(photos);
    selectedImage = imageList.first;
  }
*/

//  void update() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {},
          child: Padding(
            // leading 자체가 정해진 공간이므로 Padding 을 이용해서 사이즈를 조절해주자.
            padding: const EdgeInsets.all(15.0),
            child: ImageData(icon: IconsPath.closeImage),
          ),
        ),
        title: const Text(
          'New Post',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageData(
                icon: IconsPath.nextImage,
                width: 50,
              ),
            ),
          )
        ],
      ),
      body: Obx (()=>SingleChildScrollView(
        child: Column(
          children: [
            _imagePreview(),
            _header(),
            _imageSelectList(),
          ],
        ),
      ),
    ));
  }

  Widget _imagePreview() {
    var width = Get.width;
    return Container(
        width: width,
        height: width,
        color: Colors.grey,
        child: UploadController.to.selectedImage.value == null
            ? Container()
            : _photoWidget(
                UploadController.to.selectedImage.value!,
                width.toInt(),
                (p0) {
                  return Image.memory(
                    p0,
                    fit: BoxFit.cover,
                  );
                },
              ));
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                Text(
                  //[question] The argument type 'RxString' can't be assigned to the parameter type 'String'.
                  //[answer]
                  UploadController.to.headerTitle.value,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 5),
                decoration: BoxDecoration(
                    color: const Color(0xff808080),
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  children: [
                    ImageData(icon: IconsPath.imageSelectIcon),
                    const SizedBox(
                      width: 7,
                    ),
                    const Text(
                      '여러 항목 선택',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5,),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xff808080)),
                child: ImageData(
                  icon: IconsPath.cameraIcon,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _imageSelectList() {
    /*
    [question] ======== Exception caught by rendering library =====================================================
                The following assertion was thrown during performLayout():
                RenderBox was not laid out: RenderViewport#565b6 NEEDS-LAYOUT NEEDS-PAINT NEEDS-COMPOSITING-BITS-UPDATE
                'package:flutter/src/rendering/box.dart':
                Failed assertion: line 1978 pos 12: 'hasSize'
    [Answer] Scroll 이 겹치는 문제이다.
     */
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
        childAspectRatio: 1,
      ),
      itemCount: UploadController.to.imageList.length,
      itemBuilder: (BuildContext context, int index) {
        return _photoWidget(
          UploadController.to.imageList[index],
          200,
          (data) {
            return GestureDetector(
              onTap: () {
                UploadController.to.selectedImage.value = UploadController.to.imageList[index];
                //update();
              },
              child: Opacity(
                  opacity: UploadController.to.imageList[index] == UploadController.to.selectedImage.value ? 0.6 : 1,
                  child: Image.memory(
                    data,
                    fit: BoxFit.cover,
                  )),
            );
          },
        );
      },
    );
  }

  Widget _photoWidget(
      AssetEntity assetEntity, int size, Widget Function(Uint8List) builder) {
    // Future 가넘어오는 값을 실시간으로 데이터를 바꿔서 위젯을 생성할 때 사용한다. 알고 있지? 단발성으로 사용할 때 쓰는거
    return FutureBuilder(
        future: assetEntity.thumbnailDataWithSize(ThumbnailSize(size, size)),
        builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
          if (snapshot.hasData) {
            return builder(snapshot.data!);
          } else {
            return Container();
          }
        });
  }
}

/*
Opacity(opacity: assetEntity == selectedImage? 0.5 : 1,

              child: Image.memory(snapshot.data!, fit: BoxFit.cover,));
 */
