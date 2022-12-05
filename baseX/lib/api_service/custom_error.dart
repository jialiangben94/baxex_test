part of api_service;

/// Base Class to throw for unhandled statusCode return default -1
abstract class CustomError extends DioError {
  String message;
  int statusCode = -1;
  RequestOptions r;

  CustomError(
    message,
    r, {
    statusCode,
  }) : super(
          requestOptions: r,
        );

  @override
  String toString() {
    return message;
  }

  int getStatusCode();
}

/// Status Code is 400 will throw InvalidRequestException.
/// - message from server is not empty will throw error message
/// - else if message from server  is empty will not throw error message
class InvalidRequestException extends CustomError {
  String message;
  int statusCode;
  InvalidRequestException(RequestOptions r, this.message, this.statusCode)
      : super(
          message,
          r,
          statusCode: statusCode,
        );

  @override
  String toString() {
    return message ?? 'Invalid data, please enter the correct data';
  }

  @override
  int getStatusCode() {
    return statusCode ?? super.statusCode;
  }
}

/// Status Code is 500
/// will throw InternalServerErrorException
class InternalServerErrorException extends CustomError {
  String message;
  int statusCode;
  InternalServerErrorException(RequestOptions r, this.message, this.statusCode)
      : super(
          message,
          r,
          statusCode: statusCode,
        );

  @override
  String toString() {
    return message ?? 'Something have went wrong, please try again later';
  }

  @override
  int getStatusCode() {
    return statusCode ?? super.statusCode;
  }
}

/// Status Code is 401
/// will throw UnauthorizedException
class UnauthorizedException extends CustomError {
  String message;
  int statusCode;
  UnauthorizedException(RequestOptions r, this.message, this.statusCode)
      : super(
          message,
          r,
          statusCode: statusCode,
        );

  @override
  String toString() {
    return message ?? 'Access token has expired, please proceed to login';
  }

  @override
  int getStatusCode() {
    return statusCode ?? super.statusCode;
  }
}

/// Status Code is 409
/// will throw VersionOutdateException
class VersionOutdateException extends CustomError {
  String message;
  int statusCode;
  VersionOutdateException(RequestOptions r, this.message, this.statusCode)
      : super(
          message,
          r,
          statusCode: statusCode,
        );

  @override
  String toString() {
    return message ??
        'There is a new version available for download! Please update the app by visiting the ${Platform.isAndroid ? 'Play Store' : 'App Store'}';
  }

  @override
  int getStatusCode() {
    return statusCode ?? super.statusCode;
  }
}

/// Status Code is 404
/// will throw NotFoundException
class NotFoundException extends CustomError {
  String message;
  int statusCode;
  NotFoundException(RequestOptions r, this.message, this.statusCode)
      : super(
          message,
          r,
          statusCode: statusCode,
        );

  @override
  String toString() {
    return message ?? 'The requested information could not be found';
  }

  @override
  int getStatusCode() {
    return statusCode ?? super.statusCode;
  }
}

/// Status Code is other than status code not listed
/// will throw NoConnectionException
class NoConnectionException extends CustomError {
  String message;
  int statusCode;
  NoConnectionException(RequestOptions r, {this.message, this.statusCode})
      : super(
          message,
          r,
          statusCode: statusCode,
        );

  @override
  String toString() {
    return message ??
        'No internet connection detected, please try again later.';
  }

  @override
  int getStatusCode() {
    return statusCode ?? super.statusCode;
  }
}

/// Status Code is DioErrorType sendTimeout / connectTimeout / receiveTimeout
/// will throw TimeOutException
class TimeOutException extends CustomError {
  String message;
  int statusCode;
  TimeOutException(RequestOptions r, this.message, this.statusCode)
      : super(
          message,
          r,
          statusCode: statusCode,
        );

  @override
  String toString() {
    return message ?? 'The connection has timed out, please try again later.';
  }

  @override
  int getStatusCode() {
    return statusCode ?? super.statusCode;
  }
}

/// Status Code is 429
/// will throw TooManyRequestException
class TooManyRequestException extends CustomError {
  String message;
  int statusCode;
  TooManyRequestException(RequestOptions r, this.message, this.statusCode)
      : super(
          message,
          r,
          statusCode: statusCode,
        );

  @override
  String toString() {
    return message ??
        'The connection has request too many, please try again later.';
  }

  @override
  int getStatusCode() {
    return statusCode ?? super.statusCode;
  }
}

/// Status Code is 422
/// will throw ValidationException
class ValidationException extends CustomError {
  String message;
  int statusCode;
  ValidationException(RequestOptions r, this.message, this.statusCode)
      : super(
          message,
          r,
          statusCode: statusCode,
        );

  @override
  String toString() {
    return message;
  }

  @override
  int getStatusCode() {
    return statusCode ?? super.statusCode;
  }
}

/// Status Code is 426
/// will throw ForceUpdateException
class ForceUpdateException extends CustomError {
  String message;
  int statusCode;
  ForceUpdateException(RequestOptions r, {this.message, this.statusCode})
      : super(message, r, statusCode: statusCode);

  @override
  String toString() {
    return message ?? 'New version required to update';
  }

  @override
  int getStatusCode() {
    return statusCode ?? super.statusCode;
  }
}

/// Status Code is 503
/// will throw MaintenanceException
class MaintenanceException extends CustomError {
  String message;
  int statusCode;
  MaintenanceException(RequestOptions r, {this.message, this.statusCode})
      : super(message, r, statusCode: statusCode);

  @override
  String toString() {
    return message ?? 'Engage Life is currently down for maintenance.';
  }

  @override
  int getStatusCode() {
    return statusCode ?? super.statusCode;
  }
}
