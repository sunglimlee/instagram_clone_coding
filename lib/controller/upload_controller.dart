import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

class UploadController extends GetxController {
  // [question] Rx 값을 다루는데 문제가 될때
  // [answer] https://chornthorn.github.io/getx-docs/state-management/reactive-state-manager/index
  //var _selectedImage = const AssetEntity(id: 'temp', typeInt: 1, width: 100, height: 100).obs;
  //var _selectedImage = AssetEntity(id: 1.toString(), typeInt: 0, width: 100, height: 100).obs;
  //AssetEntity? _selectedImage = null.obs as AssetEntity?;
  Rx<AssetEntity?> selectedImage = (null as AssetEntity?).obs;
  var headerTitle = ''.obs;
  var imageList = <AssetEntity>[].obs;

  // 앨범의 리스트는 누르는순간 builder 를 통해서 새롭게 만들고 그때 이민 이 album 이 정해져 있기 때문에
  List<AssetPathEntity> _albums = <AssetPathEntity>[]; // 이건 obs 를 이욯해 상태관리를 할 필요가 없다는것

  // 지금 이게 필요는 없다. 나중에 이게 여러군데서 쓰일때 사용하면 좋은거지 Upload 객체 페이지 하나에서 사용하는데 의미가 거의 없지.
  //static UploadController get to => Get.find<UploadController>(); // to 로 언제든지 찾을 수 있도록 하고

/*
  get selectedImage => _selectedImage;
  // 다해간다. 조금만 더 집중하도록 하자.
  set selectedImage(value) {
    // value 값은 AssetEntity 인데 어떻게 하면 Rx<AssetEntity> 로 넣을 수 있나?
    print('value 의 값은 ${value.toString()}');
    _selectedImage = value; // 여기 보는것 처럼 들어오는 value 값을 Rx형에다가 대입하고 있다.
    //_selectedImage?.update((val) {val.id = value.id;});
  }
*/

/*
  get imageList => _imageList;
  set imageList(value) {
    _imageList = value;
  }
*/

  List<AssetPathEntity> get albums => _albums;
  set albums(List<AssetPathEntity> value) {
    _albums = value;
  }

  @override
  void onInit() {
    super.onInit();
    _loadPhoto();

  }

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
    // [question] Unhandled Exception: type 'String' is not a subtype of type 'RxString' in type cast
    // [answer] 괄호로 넣어주니깐 되었다.
    headerTitle(albums.first.name);
    await _pagingPhotos();
    //update();
  }

  Future<void> _pagingPhotos() async {
    var photos = await albums.first.getAssetListPaged(page: 0, size: 30);
    imageList.addAll(photos);
    selectedImage.value = imageList.first;
  }

}