import 'package:get/get.dart';
import 'package:baxex_test/app/ui/menu/menu/menu_controller.dart';

class MenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MenuController());
  }
}
