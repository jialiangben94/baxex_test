import 'package:baseX/baseX.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

enum Environment { Live, Staging }

class DefaultBaseContant extends BaseConstant {}

/// Default variable:
///
/// 1. baseUrl => Live url set in runEtcApp
/// 2. staginBaseUrl => Staging url set in runEtcApp
/// 3. languageCode => current language selected, by default is English, en. (if multi langauge is enable in runEtcApp)
/// 4. onFailed => global onFailed set in runEtcApp
abstract class BaseConstant {
  var baseUrl = '';
  var staginBaseUrl = '';

  RxString languageCode = 'en'.obs;

  GeneralErrorHandle onFailed;
}
