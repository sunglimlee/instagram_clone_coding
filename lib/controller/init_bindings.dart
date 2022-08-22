import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get.dart';
import 'package:instagram_clone_coding/controller/bottom_navigation_bar_controller.dart';

class InitBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavigationBarController(), permanent: true);
  }
}