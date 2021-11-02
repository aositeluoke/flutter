class JsonResult {
  final int code;
  final String msg;
  final dynamic data;
  final List<dynamic> list;

  JsonResult(this.code, this.msg, this.data, this.list);

  /*data为对象时使用此方法解析*/
  factory JsonResult.fromJson(dynamic json) {
    return JsonResult(json["code"], json["msg"], json["data"], []);
  }

  /*data为列表时使用此方法解析*/
  factory JsonResult.fromJsonList(dynamic json) {
    return JsonResult(json["code"], json["msg"], {}, json["data"]);
  }
  /*接口响应码0表示成功*/
  bool isOk() => code == 0;
}
