import 'package:baseX/baseX.dart';

class CustomSharePref {
  static const String _test = 'Test';

  Future<bool> saveTest(String token) async {
    return await S.prefs?.setString(_test, token) ?? false;
  }

  String get test {
    return S.prefs?.getString(_test) ?? '';
  }

  removeTest() async {
    S.prefs?.remove(_test);
  }
}
