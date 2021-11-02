import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_http/http/http_exception.dart';
import 'package:flutter_http/model/user_model.dart';

import 'api/api_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    EasyLoading.instance
      ..userInteractions = false
      ..maskColor = Colors.black12;
    return MaterialApp(
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: InkWell(
        onTap: () {
          getData();
        },
        child: Container(
          alignment: Alignment.center,
          width: 100,
          height: 100,
          child: Text("请求网络"),
          color: Colors.blue,
        ),
      ),
    );
  }

  void getData() async {
    EasyLoading.show(status: "加载中...");
    try {
      var list = await ApiAuth.getHealthList(
          userId: "26",
          startTime: "2013-08-07 00:00:00",
          endTime: "2028-09-07 00:00:00");
      List<UserModel> users = [];
      list.forEach((element) {
        users.add(UserModel.fromJson(element));
      });
    } on HttpException catch (e) {
      /*接口返回错误信息或者网络链接失败都会在这里回调*/
      EasyLoading.showToast(e.msg);
    } finally {
      Future.delayed(const Duration(seconds: 3), () {
        EasyLoading.dismiss();
      });
    }
  }
}
