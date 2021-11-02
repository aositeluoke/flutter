import 'package:dio/dio.dart';
import 'package:flutter_http/http/http_exception.dart';
import 'package:flutter_http/http/http_interceptor.dart';
import 'package:flutter_http/http/http_options.dart';
import 'package:flutter_http/model/json_result_model.dart';

/*
* 参考：https://www.yuque.com/docs/share/9ac6b95b-507c-4284-8091-65391062971e?#aRsab
* */
class HttpRequest {
  static final HttpRequest instance = HttpRequest._instance();

  late Dio dio;

  factory HttpRequest() => instance;

  HttpRequest._instance() {
    BaseOptions options = BaseOptions(
        baseUrl: HttpOptions.BASE_URL /*域名*/,
        connectTimeout: HttpOptions.CONNECT_TIME_OUT /*连接超时*/,
        receiveTimeout: HttpOptions.RECEIVE_TIME_OUT /*接收超时*/,
        headers: {});
    dio = Dio(options);
    dio.interceptors.add(HttpInterceptor());
  }

  final CancelToken _cancelToken = CancelToken();

  Future get(String path, Map<String, dynamic> params, Options? options,
      CancelToken? cancelToken) async {
    try {
      Response response = await dio.get(path,
          queryParameters: params,
          cancelToken: cancelToken ?? _cancelToken,
          options: options ?? Options());
      bool isList = response.data["data"] is List;
      JsonResult result = isList
          ? JsonResult.fromJsonList(response.data)
          : JsonResult.fromJson(response.data);
      if (result.isOk()) {
        return isList ? result.list : result.data;
      }
    } catch (e) {
      throw ((e as DioError).error as HttpException);
    }
  }

  Future post(
      String path,
      Map<String, dynamic> queryParams,
      CancelToken? cancelToken,
      Map<String, dynamic> data,
      Options? options) async {
    try {
      Response response = await dio.post(path,
          queryParameters: queryParams,
          cancelToken: cancelToken ?? _cancelToken,
          data: data,
          options: options ?? Options());
      bool isList = response.data["data"] is List;
      JsonResult result = isList
          ? JsonResult.fromJsonList(response.data)
          : JsonResult.fromJson(response.data);
      if (result.isOk()) {
        return isList ? result.list : result.data;
      } else {
        throw HttpException(code: result.code, msg: result.msg);
      }
    } catch (e) {
      print("post====$e");
      throw ((e as DioError).error as HttpException);
    }
  }
}
