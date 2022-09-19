import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:instagram_clone_coding/widgets/image_data.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_coding/controller/upload_controller.dart';

// var albums = <AssetPathEntity>[]; // 이거 똑같은 뜻인거 맞지? 확실하지?
class Upload extends GetView<UploadController> {
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
          onTap: () {
            Get.back();
          },
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            _imagePreview(),
            _header(),
            _imageSelectList(),
          ],
        ),
      ),
    );
  }

  Widget _imagePreview() {
    var width = Get.width;
    return Container(
        width: width,
        height: width,
        color: Colors.grey,
        child: Obx(
          () => controller.selectedImage.value == null
              ? Container()
              : _photoWidget(
                  controller.selectedImage.value!,
                  width.toInt(),
                  (p0) {
                    return Image.memory(
                      p0,
                      fit: BoxFit.cover,
                    );
                  },
                ),
        ));
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              // 안되는건 빨리 다른 대안을 찾아보도록 하자.. 안되는것 억지로 붙들고 있는것도 시간 낭비다.
              // Get.bottomSheet 포기했다. 다른데 찾아보니 ExpandableBottomSheet 이런것도 있던데..
              showModalBottomSheet(
                  context: Get.context!,
                  // 왜 shape: 가 없는거지?
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(Get.context!).size.height -
                        MediaQuery.of(Get.context!).padding.top,
                  ),
                  isScrollControlled:
                      controller.albums.length > 10 ? true : false,
                  builder: (_) => SizedBox(
                        height: controller.albums.length > 10
                            ? Size.infinite.height
                            : controller.albums.length * 60,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Center(child: _sheetHandle()),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    ...List.generate(
                                        controller.albums.length,
                                        (index) => GestureDetector(
                                              onTap: () {
                                                // [question] HeaderTitle 이 변경이 되어야 하고..
                                                // [answer] HeaderTitle 의 값을 바꾸면 obs -> obx 로 자동으로 갱신..
                                                //controller.headerTitle(controller.albums[index].name);
                                                controller.loadData(whichAlbums: index); // 이부분 곰곰히 생각해보자. controller.loadPhoto() 를 하게되면 다운로드 받은 파일을 갱신할 수 잇지.
                                                Get.back();
                                                // [question] 각각의 이미지 리스트가 변경이 되어야 하고
                                                // [answer] 이 리스트도 다시 호출 해주면 될 것 같은데..

                                                //_imageSelectList();
                                                // [question] 이미지 프리뷰 부분이 변경이 되어야 하고
                                                // [answer] 이부분도 리스트를 다시 호출 해주면 될 것 같은데
                                                //_imagePreview();
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 15,
                                                        horizontal: 20),
                                                child: Text(controller
                                                    .albums[index].name),
                                              ),
                                            )),
/*
                                    Container(
                                      child: Text('aaa'),
                                    ),
                                    Container(
                                      child: Text('aaa'),
                                    ),
                                    Container(
                                      child: Text('aaa'),
                                    ),
                                    Container(
                                      child: Text('aaa'),
                                    ),
                                    Container(
                                      child: Text('aaa'),
                                    ),
                                    Container(
                                      child: Text('aaa'),
                                    ),
                                    Container(
                                      child: Text('aaa'),
                                    ),
                                    Container(
                                      child: Text('aaa'),
                                    ),
                                    Container(
                                      child: Text('aaa'),
                                    ),
                                    Container(
                                      child: Text('aaa'),
                                    ),
                                    Container(
                                      child: Text('aaa'),
                                    ),
*/
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ));
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Obx(
                    () => Text(
                      //[question] The argument type 'RxString' can't be assigned to the parameter type 'String'.
                      //[answer]
                      controller.headerTitle.value,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 19, vertical: 5),
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
              const SizedBox(
                width: 5,
              ),
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
    return Obx(
      // obs 에 대응하는 곳들을 전부 obx 로 잡아 주었다.
      () => GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          childAspectRatio: 1,
        ),
        // 위에 Obx 로 감싸주었기 때문에 값의 변경이 생기면 자동으로 이부분을 갱신한다.
        // 그래서 변경되었다치고 계속 작업을 이어나가면 되는거지.
        itemCount: controller.imageList.length,
        itemBuilder: (BuildContext context, int index) { // 길이에 맞춰서 다시금 빌더가 된다.
          return _photoWidget(
            // 이부분을 잘 봐라. AssetEntity 를 사용하고 있지.
            // 왜냐고? 모든 OS 애 적절히 대응하려고
            // 추후 thumbnailDataWithSize 를 이용해서 그림을 받아올 때 이 함수의 리턴값이 Future<Unit8List> 이므로 FutureBuilder 함수를 이용해야 한다.
            controller.imageList[index],
            200,
            (data) { // 여기서도 콜백함수를 이용하고 있다.
              return Obx(
                () => GestureDetector(
                  onTap: () {
                    controller.selectedImage.value = // 프리뷰 이미지를 위한 변수를 바꾸어주고, obx 이므로 자동으로 프리뷰 이미지가 바뀌고
                        controller.imageList[index];
                    //update();
                  },
                  child: Opacity( // 해당 이미지에다가 Opacity 를 적용하였고
                      opacity: controller.imageList[index] ==
                              controller.selectedImage.value
                          ? 0.6
                          : 1,
                      child: Image.memory( // unit8List 파일을 불러들이기 위해 Image.memory 를 사용했다.,
                        data,
                        fit: BoxFit.cover, // 꽉 채웠고
                      )),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _photoWidget( // 이부분은 아직 잘 모르겠다.
      AssetEntity assetEntity, int size, Widget Function(Uint8List) builder) {
    // Future 가넘어오는 값을 실시간으로 데이터를 바꿔서 위젯을 생성할 때 사용한다. 알고 있지? 단발성으로 사용할 때 쓰는거
    return FutureBuilder( // Future 를 리턴하는 값을 이용해서 Widget 을 build 한다. 그래서 FutureBuilder
        // 넣어주는 assetEntity 를 이용하고, thumbnailDataWithSize 함수를 이용하면 돌아오는 값이 Future<Unit8List> 이므로 FutureBuilder 를 이용하면 되는구나.
        future: assetEntity.thumbnailDataWithSize(ThumbnailSize(size, size)), // 여기가 값을 넣어주는 부분이고
        builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) { // 여기가 넣어준 값으로 위젯을 만드는 부분이고
          if (snapshot.hasData) {
            return builder(snapshot.data!);
          } else {
            return Container();
          }
        });
  }

  Widget _sheetHandle() {
    // 이거 완전 대박이다. 내가 직접 이렇게 List.generate 사용법을 알고 있는거네..
    return Column(
      children: List.generate(2, (index) {
        return Container(
          margin: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1),
            color: Colors.black54,
          ),
          width: 40,
          height: 4,
        );
      }),
    );
  }
}

/*
Opacity(opacity: assetEntity == selectedImage? 0.5 : 1,

              child: Image.memory(snapshot.data!, fit: BoxFit.cover,));
 */
