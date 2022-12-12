import 'package:baseX/baseX.dart';
import 'package:flutter_hms_gms_checker/flutter_hms_gms_checker.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:huawei_hmsavailability/huawei_hmsavailability.dart';

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

  late GeneralErrorHandle onFailed;

  /// 0: HMS Core (APK) is available.
  ///
  /// 1: No HMS Core (APK) is found on device.
  ///
  /// 2: HMS Core (APK) installed is out of date.
  ///
  /// 3: HMS Core (APK) installed on the device is unavailable.
  ///
  /// 9: HMS Core (APK) installed on the device is not the official version.
  ///
  /// 21: The device is too old to support HMS Core (APK)
  ///
  Future<bool> isHMS() async {
    if (GetPlatform.isIOS) return false;
    HmsApiAvailability client = HmsApiAvailability();
    int status = await client.isHMSAvailable();
    bool _isGMS = await isGMS();
    return status == 0 && !_isGMS;
    // -- Added !_isGMS to ensure the device have actually no GMS, else still can proceed GMS services.
  }

  Future<bool> isGMS() async {
    if (GetPlatform.isIOS) return false;
    bool result = await FlutterHmsGmsChecker.isGmsAvailable;
    return result;
  }
}
