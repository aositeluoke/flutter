import 'package:dio/dio.dart';

class HttpException implements Exception {
  final int code;

  final String msg;

  HttpException({this.code = 500, this.msg = "网络连接失败"});

  factory HttpException.create(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        return HttpException(code: -1, msg: '请求取消');
        break;
      case DioErrorType.connectTimeout:
        return HttpException(code: -1, msg: '连接超时');
        break;
      case DioErrorType.sendTimeout:
        return HttpException(code: -1, msg: '请求超时');
        break;
      case DioErrorType.receiveTimeout:
        return HttpException(code: -1, msg: '响应超时');
        break;
      case DioErrorType.response:
        // 服务器异常
        int statusCode = error.response?.statusCode ?? -1;
        switch (statusCode) {
          case 400:
            return HttpException(code: statusCode, msg: '请求语法错误');
            break;
          case 401:
            return HttpException(code: statusCode, msg: '没有权限');
            break;
          case 403:
            return HttpException(code: statusCode, msg: '服务器拒绝执行');
            break;
          case 404:
            return HttpException(code: statusCode, msg: '无法连接服务器');
            break;
          case 500:
            return HttpException(code: statusCode, msg: '服务器内部错误');
            break;
          case 502:
            return HttpException(code: statusCode, msg: '无效的请求');
            break;
          case 503:
            return HttpException(code: statusCode, msg: '服务器挂了');
            break;
          case 505:
            return HttpException(code: statusCode, msg: '不支持HTTP协议请求');
            break;
          default:
            return HttpException(
              code: statusCode,
              msg: error.response?.statusMessage ?? "未知错误",
            );
        }
      default:
        {
          if (error.message.contains("SocketException")) {
            return HttpException(code: 500, msg: "网络连接失败,请先连接网络！");
          } else {
            return HttpException(code: 500, msg: error.message);
          }
        }
    }
  }

  @override
  String toString() {
    return 'HttpException{code: $code, msg: $msg}';
  }
}
