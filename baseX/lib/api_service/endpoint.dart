import 'package:baseX/api_service/api_service.dart';

class EndPoint extends Data {
  final String productionApi;
  final String stagingApi;
  final String productionWeb;
  final String stagingWeb;

  EndPoint({
    this.productionApi,
    this.stagingApi,
    this.productionWeb,
    this.stagingWeb,
  });

  factory EndPoint.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return EndPoint(
      productionApi: json['production'],
      stagingApi: json['staging'],
      productionWeb: json['production_web_endpoint'],
      stagingWeb: json['staging_web_endpoint'],
    );
  }

  // @override
  Map<String, dynamic> toJson() => {
        'productionApi': productionApi,
        'stagingApi': stagingApi,
        'productionWeb': productionWeb,
        'stagingWeb': stagingWeb,
      };
}
