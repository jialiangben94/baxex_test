import 'package:baseX/baseX.dart';

class MenuController extends BaseXController {
  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
  }

  onSwitchChange(bool value) {}

  @override
  Future<bool> onBack() async => true;
}
