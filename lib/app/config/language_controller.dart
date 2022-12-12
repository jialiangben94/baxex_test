import 'package:baseX/baseX.dart';
import 'package:baxex_test/app/config/app_constant.dart';
import 'package:baxex_test/app/model/view/label.dart';

class LanguageController extends AppTranslationX<Label> {
  @override
  // TODO: implement LANG_LIST
  List<LanguageModel> get LANG_LIST => [
        LanguageModel(title: "English", code: "en"),
        LanguageModel(title: "简体中文", code: "zh"),
        LanguageModel(title: "Bahasa Malaysia", code: "bm")
      ];

  @override
  Label? fromJson(source) {
    // TODO: implement fromJson
    return Label.fromJson(source);
  }

  @override
  String? translate(String key, String languageCode, List<Label> list) {
    // TODO: implement translate
    try {
      String? value;
      if (AppConstant().languageCode.value == 'en') {
        value = list.firstWhere((item) => item.key == key).enValue;
      } else if (AppConstant().languageCode.value == 'bm') {
        value = list.firstWhere((item) => item.key == key).bmValue;
      } else {
        value = list.firstWhere((item) => item.key == key).cnValue;
      }
      if ((value ?? "").isEmpty) {
        return null;
      }
      return value!.replaceAll('\\n', '\n');
    } catch (e) {
      return null;
    }
  }
}
