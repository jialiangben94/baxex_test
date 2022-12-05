import 'package:shared_preferences/shared_preferences.dart';

SharePref S = SharePref.sharePref;

class SharePref {
  static SharedPreferences _prefs;
  static final SharePref sharePref = SharePref._();
  SharePref._();

  static const String _tokenKey = 'AccessToken';
  static const String _loginPhoneCodeKey = 'LoginPhoneCode';
  static const String _loginPhoneNoKey = 'LoginPhoneNo';
  static const String _userIDKey = 'UserID';
  static const String _languageCodeKey = 'LanguageCode';
  static const String _fcmTokenKey = 'FcmToken';
  static const String _isHMSKey = 'IsHMS';

  Future initialize() async {
    if (_prefs != null) return _prefs;

    _prefs = await SharedPreferences.getInstance();

    print((_prefs == null)
        ? 'Shared Preferences failed to initialize'
        : 'Shared Preferences is initialized');
  }

  Future<bool> saveAccessToken(String token) async {
    return await _prefs.setString(_tokenKey, token) ?? false;
  }

  String get accessToken {
    return _prefs.getString(_tokenKey) ?? '';
  }

  String get fastAccessToken {
    return _prefs?.getString(_tokenKey) ?? '';
  }

  removeAccessToken() async {
    _prefs.remove(_tokenKey);
  }

  Future<bool> saveLoginPhoneCode(String loginPhoneCode) {
    return _prefs.setString(_loginPhoneCodeKey, loginPhoneCode) ?? false;
  }

  String get loginPhoneCode {
    return _prefs.getString(_loginPhoneCodeKey) ?? '';
  }

  removeLoginPhoneCode() async {
    _prefs.remove(_loginPhoneCodeKey);
  }

  Future<bool> saveLoginPhoneNo(String loginPhoneNo) {
    return _prefs.setString(_loginPhoneNoKey, loginPhoneNo) ?? false;
  }

  String get loginPhoneNo {
    return _prefs.getString(_loginPhoneNoKey) ?? '';
  }

  removeLoginPhoneNo() async {
    _prefs.remove(_loginPhoneNoKey);
  }

  Future<bool> saveUserID(String userID) {
    return _prefs.setString(_userIDKey, userID) ?? false;
  }

  String get userID {
    return _prefs.getString(_userIDKey) ?? '';
  }

  removeUserID() async {
    _prefs.remove(_userIDKey);
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

  Future<bool> saveIsHMS(bool isHMS) {
    return _prefs.setBool(_isHMSKey, isHMS) ?? false;
  }

  bool get isHMS {
    return _prefs.getBool(_isHMSKey) ?? '';
  }
}
