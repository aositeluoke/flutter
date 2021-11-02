import 'package:dio/dio.dart';
import 'package:flutter_http/http/http_exception.dart';

class HttpInterceptor extends Interceptor {
  /*请求拦截 添加token,打印调试*/
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Map<String, dynamic> tokenMap = {
      "token": "login_jxwdevice346502ffbtloq0d88fupal8404yfvevd8qjz63"
    };
    if (options != null) {
      if (options.headers != null) {
        options.headers.addAll(tokenMap);
      } else {
        options.headers = tokenMap;
      }
    }
    print("");
    print("");
    print("");
    print("");
    print("=================请求start==================");
    print("[请求]：${options.uri}");
    print("[请求]：${options.headers}");
    print("[请求]：${options.queryParameters}");
    print("=================请求end==================");
    print("");
    print("");
    print("");
    print("");
    super.onRequest(options, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    err.error = HttpException.create(err);
    super.onError(err, handler);
  }

  /*响应拦截打印调试*/
  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    print("");
    print("");
    print("");
    print("");
    print("=================结果start==================");
    print("[结果]：${response.realUri}");
    print("[结果]：$response");
    print("=================结果end==================");
    print("");
    print("");
    print("");
    print("");
    super.onResponse(response, handler);
  }
}
