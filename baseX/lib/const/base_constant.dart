import 'package:baseX/baseX.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

enum Environment { Live, Staging }

class DefaultBaseContant extends BaseConstant {}

abstract class BaseConstant {
  var api_version = '1.0.0';
  var baseUrl = '';
  var staginBaseUrl = '';

  List<String> get language => [
        '中文',
        'English',
        'Bahasa Melayu',
      ];

  List<String> get languageCodeList => [
        'zh',
        'en',
        'ms',
      ];

  RxString languageCode = 'en'.obs;

  GeneralErrorHandle onFailed;
}
