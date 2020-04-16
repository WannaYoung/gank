import 'Api.dart';
import 'http_method.dart';
import 'base_entity.dart';
import 'error_entity.dart';
import 'package:dio/dio.dart';

class DioManager {
  static final DioManager _shared = DioManager._internal();
  factory DioManager() => _shared;

  Dio dio;
  DioManager._internal() {
    if (dio == null) {
      BaseOptions options = BaseOptions(
          baseUrl: Api.host,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          receiveDataWhenStatusError: true,
          connectTimeout: 30000,
          receiveTimeout: 3000,
          headers: {"Accept": "application/json"}
      );
      dio = Dio(options);
    }
  }

  Future request<T>(
      HttpMethod method,
      String path, {
        Map<String, dynamic> params,
        Function(T) success,
        Function(ErrorEntity) error
      }
  ) async {
    print(path);
    try {
      Response response = await dio.request(
                                      path,
                                      queryParameters: params,
                                      options: Options(method: HttpMethodValues[method])
      );
      if (response != null) {
        BaseEntity entity = BaseEntity<T>.fromJson(response.data);
        if (entity.status == 100) {
          success(entity.data);
        } else {
          error(ErrorEntity(status: entity.status, message: entity.message));
        }
      } else {
        error(ErrorEntity(status: -1, message: "未知错误"));
      }
    } on DioError catch(e) {
      error(createErrorEntity(e));
    }
  }

  Future requestList<T>(
      HttpMethod method,
      String path, {
        Map<String, dynamic> params,
        Function(List<T>) success,
        Function(ErrorEntity) error
      }
  ) async {
    try {
      Response response = await dio.request(path,
                                      queryParameters: params,
                                      options: Options(method: HttpMethodValues[method])
      );
      print(path);
      if (response != null) {
        BaseListEntity entity = BaseListEntity<T>.fromJson(response.data);
        if (entity.status == 100) {
          success(entity.data);
        } else {
          error(ErrorEntity(status: entity.status, message: entity.message));
        }
      } else {
        error(ErrorEntity(status: -1, message: "未知错误"));
      }
    } on DioError catch(e) {
      error(createErrorEntity(e));
    }
  }

  ErrorEntity createErrorEntity(DioError error) {
    switch (error.type) {
      case DioErrorType.CANCEL: {
        return ErrorEntity(status: -1, message: "请求取消");
      }
      break;
      case DioErrorType.CONNECT_TIMEOUT: {
        return ErrorEntity(status: -1, message: "连接超时");
      }
      break;
      case DioErrorType.RECEIVE_TIMEOUT: {
        return ErrorEntity(status: -1, message: "响应超时");
      }
      break;
      case DioErrorType.SEND_TIMEOUT: {
        return ErrorEntity(status: -1, message: "请求超时");
      }
      break;
      case DioErrorType.RESPONSE: {
        try {
          int errCode = error.response.statusCode;
          String errMessage = error.response.statusMessage;
          return ErrorEntity(status: errCode, message: errMessage);
        } on Exception catch (_) {
          return ErrorEntity(status: -1, message: "未知错误");
        }
      }
      break;
      default: {
        return ErrorEntity(status: -1, message: error.message);
      }
    }
  }

}


