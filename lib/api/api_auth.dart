import 'package:flutter/cupertino.dart';
import 'package:flutter_http/http/http_request.dart';

/*相当于Android Retrofit接口====*/
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
