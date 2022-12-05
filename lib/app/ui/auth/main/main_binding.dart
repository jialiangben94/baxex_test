import 'package:baxex_test/app/ui/auth/main/main_controller.dart';
import 'package:get/get.dart';

class MainBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(MainController());
  }
}
