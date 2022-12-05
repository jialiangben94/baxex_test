import 'package:baseX/baseX.dart';

class MenuController extends BaseXController {
  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
  }

  @override
  Future<bool> onBack() async => true;
}
