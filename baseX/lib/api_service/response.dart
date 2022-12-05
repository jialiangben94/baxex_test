part of api_service;

/// AResponse is a base response to receive other param exclude data
class AResponse {
  final String message;
  final dynamic data;

  AResponse({
    this.message,
    this.data,
  });

  factory AResponse.fromJson(Map<String, dynamic> json, {Function(Map<String, dynamic>) create}) {
    var jsonData = json['data'];

    return AResponse(
      message: json['message'],
      data: create != null ? create(jsonData) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'data': data,
      };
}

abstract class Data {
  Data();
  // @protected
  // Data.fromJson(Map<String, dynamic> json);

  // @protected
  // List<T> listFromJson(List json);
  // Map<String, dynamic> toJson();
}

class SocialData {
  final String id;
  final String name;
  final String email;
  // final String imageUrl;
  final String providerName;

  SocialData(this.id, this.name, this.email, this.providerName); // this.imageUrl

  SocialData.google(this.id, this.name, this.email, {this.providerName = 'google'});

  SocialData.facebook(this.id, this.name, this.email, {this.providerName = 'facebook'});

  SocialData.apple(this.id, this.name, this.email, {this.providerName = 'apple'});
}
