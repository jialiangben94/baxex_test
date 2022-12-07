import 'package:shared_preferences/shared_preferences.dart';

SharePref S = SharePref.sharePref;

/// Share Preference will auto initialize when class is pass into runEtcApp
/// Able to get Share preference by calling S.prefs
///
/// Below are the lists that will have in base share preference follow by the function
/// 1. Access Token
///   a. saveAccessToken
///   b. accessToken
///   c. removeAccessToken
///
/// 2. Language Code
///   a. saveLanguageCode
///   b. languageCode
///
/// 3. Fcm Token
///   a. saveFcmToken
///   b. fcmToken
class SharePref {
  static SharedPreferences _prefs;
  static final SharePref sharePref = SharePref._();
  SharePref._();

  static const String _tokenKey = 'AccessToken';
  static const String _languageCodeKey = 'LanguageCode';
  static const String _fcmTokenKey = 'FcmToken';

  Future initialize() async {
    if (_prefs != null) return _prefs;

    _prefs = await SharedPreferences.getInstance();

    print((_prefs == null)
        ? 'Shared Preferences failed to initialize'
        : 'Shared Preferences is initialized');
  }

  SharedPreferences get prefs => _prefs;

  Future<bool> saveAccessToken(String token) async {
    return await _prefs.setString(_tokenKey, token) ?? false;
  }

  String get accessToken {
    return _prefs.getString(_tokenKey) ?? '';
  }

  removeAccessToken() async {
    _prefs.remove(_tokenKey);
  }

  Future<bool> saveLanguageCode(String code) {
    return _prefs.setString(_languageCodeKey, code) ?? false;
  }

  String get languageCode {
    return _prefs.getString(_languageCodeKey) ?? 'en';
  }

  Future<bool> saveFcmToken(String code) {
    return _prefs.setString(_fcmTokenKey, code) ?? false;
  }

  String get fcmToken {
    return _prefs.getString(_fcmTokenKey) ?? '';
  }
}
