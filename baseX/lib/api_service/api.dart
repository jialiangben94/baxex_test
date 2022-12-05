part of api_service;

typedef OnFail = bool Function(int code, String message, dynamic result);
typedef OnGenericCallBack = void Function(String message, dynamic result);
typedef FromJsonM = Function(Map<String, dynamic> data);

enum HttpMethod { get, post, put, delete }
enum HeaderType { none, standard, authorized }
enum ApiVersion { v, v1, v2, v3 }

/// ApiVersion Enum return value
extension ApiVersionExtension on ApiVersion {
  String get value {
    switch (this) {
      case ApiVersion.v1:
        return 'v1';
      case ApiVersion.v2:
        return 'v2';
      default:
        return '';
    }
  }
}

const multipartHeader = 'multipart/form-data';
const timeoutDuration = Duration(minutes: 1);
Dio dio;

/// Api class will put on main.dart
class Api {
  Api() {
    if (dio == null) {
      dio = Dio();
      dio.interceptors.add(ApiInterceptors());
      dio.options.connectTimeout = timeoutDuration.inMilliseconds;
      dio.options.baseUrl = baseConstant.baseUrl;
      print('Api initialzed with constant endpoint.');
    }
  }

  setNewEndpoint(String endPoint) async {
    if (dio != null) {
      dio.options.baseUrl = endPoint;
    }
  }
}

/// get request
Future get(String endpoint, OnFail onFailed,
    {FromJsonM create,
    ApiVersion v = ApiVersion.v1,
    bool requiredToken = true,
    String pathParam,
    Map<String, dynamic> queryParam}) async {
  try {
    await getHeaderType(requiredToken);
    Response response = await dio.get(
        apiHostWithVersion(
          endpoint,
          v,
          pathParam: pathParam,
        ),
        queryParameters: queryParam);
    AResponse aResponse = AResponse.fromJson(response.data, create: create);
    return aResponse.data;
  } catch (e) {
    print('error in get: $e');
    Map<String, dynamic> exec = processError(e);
    onFailed(exec['statusCode'], exec['message'], null);
  }
}

/// post request
Future post(String endpoint, Map<String, dynamic> body, OnFail onFailed,
    {FromJsonM create,
    ApiVersion v = ApiVersion.v1,
    OnGenericCallBack onSuccess,
    bool requiredToken = true}) async {
  try {
    await getHeaderType(requiredToken);
    FormData formData = FormData.fromMap(body);
    Response response =
        await dio.post(apiHostWithVersion(endpoint, v), data: formData);
    AResponse aResponse = AResponse.fromJson(
      response.data,
      create: create,
    );

    if (onSuccess != null) {
      onSuccess(aResponse.message, aResponse.data);
    }

    return aResponse.data;
  } catch (e) {
    print('error in post: $e');
    Map<String, dynamic> exec = processError(e);
    onFailed(exec['statusCode'], exec['message'], null);
  }
}

/// put request
Future put(
  String endpoint,
  Map<String, dynamic> body,
  OnFail onFailed, {
  ApiVersion v = ApiVersion.v1,
  OnGenericCallBack onSuccess,
  bool requiredToken = true,
}) async {
  try {
    await getHeaderType(requiredToken);
    Response response =
        await dio.put(apiHostWithVersion(endpoint, v), data: body);
    AResponse aResponse = AResponse.fromJson(response.data);
    if (onSuccess != null) {
      onSuccess(aResponse.message, aResponse.data);
    }
    return aResponse.data;
  } catch (e) {
    Map<String, dynamic> exec = processError(e);
    onFailed(exec['statusCode'], exec['message'], null);
  }
}

/// delete request
Future delete(String endpoint, String pathParam, OnFail onFailed,
    {FromJsonM create,
    ApiVersion v = ApiVersion.v1,
    OnGenericCallBack onSuccess,
    bool requiredToken = true,
    Map<String, dynamic> queryParam}) async {
  try {
    await getHeaderType(requiredToken);
    Response response = await dio.delete(
        apiHostWithVersion(endpoint, v, pathParam: pathParam),
        queryParameters: queryParam);
    AResponse aResponse = AResponse.fromJson(response.data);
    if (onSuccess != null) {
      onSuccess(aResponse.message, aResponse.data);
    }
    return aResponse.data;
  } catch (e) {
    Map<String, dynamic> exec = processError(e);
    onFailed(exec['statusCode'], exec['message'], null);
  }
}

/// Put authorized or not based on requiredToken bool
Future<void> getHeaderType(bool requiredToken) {
  if (requiredToken) {
    dio.options.headers.addAll({'headerType': HeaderType.authorized});
  } else {
    dio.options.headers.addAll({'headerType': HeaderType.standard});
  }
  return null;
}

/// Put api endpoint with api version/path param combination if both value not null
String apiHostWithVersion(String endpoint, ApiVersion apiVersion,
    {String pathParam}) {
  if (apiVersion == ApiVersion.v) {
    return '/$endpoint${pathParam != null && pathParam != '' ? '/$pathParam' : ''}';
  } else if (apiVersion == ApiVersion.v1) {
    return '/${ApiVersion.v1.value}/$endpoint${pathParam != null && pathParam != '' ? '/$pathParam' : ''}';
  }
  return endpoint;
}

Map<String, dynamic> processError(var exception) {
  Map<String, dynamic> exec;
  switch (exception.runtimeType) {
    case InvalidRequestException:
      exec = {
        'statusCode': 400,
        'message': exception.toString(),
      };
      break;
    case InternalServerErrorException:
      exec = {
        'statusCode': 500,
        'message': exception.toString(),
      };
      break;
    case UnauthorizedException:
      exec = {
        'statusCode': 401,
        'message': exception.toString(),
      };
      break;
    case NotFoundException:
      exec = {
        'statusCode': 404,
        'message': exception.toString(),
      };
      break;
    case NoConnectionException:
      exec = {
        'statusCode': -1, //exception.getStatusCode(),
        'message': exception.toString(),
      };
      break;
    case TimeOutException:
      exec = {
        'statusCode': -1,
        'message': exception.toString(),
      };
      break;
    case TooManyRequestException:
      exec = {
        'statusCode': 429,
        'message': exception.toString(),
      };
      break;
    case ValidationException:
      exec = {
        'statusCode': 422,
        'message': exception.toString(),
      };
      break;
    case ForceUpdateException:
      exec = {
        'statusCode': 409,
        'message': exception.toString(),
      };
      break;
    case MaintenanceException:
      exec = {
        'statusCode': 503,
        'message':
            'Under Maintenance. We will be back soon.', //exception.toString(),
      };
      break;
    default:
      exec = {
        'statusCode': 520,
        'message':
            'Server error. Please try again later.', //exception.toString(),
      };
      break;
  }
  return exec;
}

class ApiInterceptors extends Interceptor {
  var _cache = <Uri, Response>{};

  Map<String, String> header = {
    Headers.acceptHeader: Headers.jsonContentType,
    // 'App-Version': C.version != '' ? C.version : '1.0.0',
    'Os-Type': Platform.isIOS ? 'ios' : 'android',
    // 'Version-Type': C.versionType,
    // 'Label-Version': C.labelVersion,
    'API-Version': baseConstant.api_version,
    'Accept-Language': baseConstant.languageCode.value,
    'Device-Type': Platform.isIOS ? 'ios' : 'android',
    // 'Device-Model': C.deviceModel.replaceAll(RegExp('[^\u0001-\u007F]'), '_'),
    // 'Device-ID': C.deviceId,
    // 'Os-Version': C.osVersion,
  };

  /// Request on header
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers.containsKey('headerType')) {
      if (options.headers['headerType'] == HeaderType.authorized) {
        // options.headers.addAll(
        //     {HttpHeaders.authorizationHeader: 'Bearer ${C.accessToken}'});
      }

      options.headers.remove('headerType');
      options.headers.addAll(header);
    }
    print('==========---------- START REQUEST ----------==========');
    print(
        'METHOD: ${options.method != null ? options.method.toUpperCase() : 'METHOD'}');
    print('BASEURL: ${options.baseUrl ?? ''}');
    print('PATH: ${options.path ?? ''}');
    print('########## HEADER ##########');
    if (options.headers.isNotEmpty) {
      options.headers.forEach((k, v) => print('$k: $v'));
    } else {
      print('NO HEADER');
    }
    print('########## HEADER ##########');
    print('########## BODY ##########');
    print('QUERY PARAM: ${options.queryParameters.toString() ?? ''}');
    if (options.data != null) {
      print(options.data.toString());
    } else {
      print('NO BODY');
    }
    print('########## BODY ##########');
    print('==========---------- END REQUEST ----------==========');
    return super.onRequest(options, handler);
  }

  /// Request on error will throw custom Exception Error
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('==========---------- START ERROR ----------==========');
    print('RESPONSE STATUS CODE: ${err.response?.statusCode}');
    // if (err.response?.data != null)
    // print('SERVER STATUS MESSAGE: ${err.response?.data['message']}');
    // if (err.response?.data != null)
    //   print('ERROR_KEY : ${err.response?.data['error_key']}');
    if (err.response?.statusCode == 422) {
      print(err.response.data['message']);
    }
    print('==========---------- END ERROR ----------==========');
    DioError customError;
    switch (err.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        customError = TimeOutException(err.requestOptions,
            err.response.data['message'], err.response?.statusCode);
        break;
      case DioErrorType.response:
        switch (err.response?.statusCode) {
          case 400:
            print('code: ${err.response?.data['code']}');
            if ((err.response?.data['code']) != null &&
                err.response?.data['code'] != 40000) {
              print('innnnnnnnn');
              throw err;
            }

            if (err.response.data['message'] != '') {
              customError = InvalidRequestException(err.requestOptions,
                  err.response.data['message'], err.response?.statusCode);
            } else {
              throw '';
            }
            break;
          case 401:
            customError = UnauthorizedException(err.requestOptions,
                err.response.data['message'], err.response?.statusCode);
            break;
          case 404:
            customError = NotFoundException(err.requestOptions,
                err.response.data['message'], err.response?.statusCode);
            break;
          case 422:
            customError = ValidationException(err.requestOptions,
                err.response.data['message'], err.response?.statusCode);
            break;
          case 429:
            customError = TooManyRequestException(err.requestOptions,
                err.response.data['message'], err.response?.statusCode);
            break;
          case 409:
            customError = ForceUpdateException(err.requestOptions,
                message: err.response.data['message'],
                statusCode: err.response?.statusCode);
            break;
          case 503:
            print('error response data: ${err.response.data['message']}');
            customError = MaintenanceException(err.requestOptions,
                message: err.response.data['message'],
                statusCode: err.response?.statusCode);
            break;
          default:
            customError = InternalServerErrorException(err.requestOptions,
                err.response.data['message'], err.response?.statusCode);
            break;
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        customError = NoConnectionException(
          err.requestOptions,
        );
        break;
    }

    // if (err.type == DioErrorType.connectTimeout || err.type == DioErrorType.other) {
    //   Response cachedResponse = _cache[err.requestOptions.uri];
    //   print('>>>>>1>>>>');
    //   if (cachedResponse != null) {
    //     print('>>>>>2>>>>');
    //     return handler.resolve(cachedResponse);
    //   }
    // }

    // print('>>>>>3');

    return super.onError(customError, handler);
  }

  /// Request on response
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    print('==========---------- START RESPONSE ----------==========');
    print('Response: ${response.data}');
    print('Status Code: ${response.data['code']}');
    print('==========---------- END RESPONSE ----------==========');

    // _cache[response.requestOptions.uri] = response;

    return handler.next(response);
  }
}
