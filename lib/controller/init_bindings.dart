import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_coding/controller/bottom_nav_controller.dart';
import 'package:instagram_clone_coding/controller/upload_controller.dart';

class InitBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavController(), permanent: true); // 앱이 종료되는 시점까지 컨트롤러가 계속 살아있도록 한다.
  }
}