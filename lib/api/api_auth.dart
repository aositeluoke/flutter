import 'package:flutter/cupertino.dart';
import 'package:flutter_http/http/http_request.dart';

class ApiAuth {
  static Future getHealthList(
      {@required userId, @required startTime, @required endTime}) async {
    return await HttpRequest().get(
        "/api/jxwdevice/healthInfo",
        {
          "userId": userId,
          "startTime": startTime,
          "endTime": endTime,
        },
        null,
        null);
  }
}
