import 'dart:convert';

class FormLocalModel {
  final String name;
  final String code;
  FormLocalModel({
    this.name,
    this.code,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'code': code});

    return result;
  }

  factory FormLocalModel.fromMap(Map<String, dynamic> map) {
    return FormLocalModel(
      name: map['name'] ?? '',
      code: map['code'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FormLocalModel.fromJson(String source) =>
      FormLocalModel.fromMap(json.decode(source));
}
