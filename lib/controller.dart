import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'variable_response.dart';

const PATH = "https://specific.sahavi.vn/public/api";

class SpecificHandleController extends GetxController {
  var mapVariable = RxMap<String, ItemTextController>();
  var textInput = TextEditingController();

  var textHandle = "".obs;
  var running = false.obs;
  var funcName = "".obs;
  var result = "".obs;
  var textHandlePhp = "".obs;

  SpecificHandleController() {
    textInput.text = """SoLonHon(a:R,b:R)c:R
pre
post ((c=a)&&(a>=b))||((c=b)&&(b>a))""";
  }

  void run() async {
    mapVariable({});
    result.value = "";
    textHandlePhp.value = "";

    running.value = true;
    textHandle.value = "Đang chuẩn bị...";
    await Future.delayed(Duration(seconds: 1));
    textHandle.value = "Đang lấy danh sách biến...";
    await getListVariable();

    running.value = false;

    Fluttertoast.showToast(
        msg: "Thành công",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<void> getListVariable() async {
    await Future.delayed(Duration(seconds: 1));
    try {
      var dio = Dio();
      var res =
          await dio.post(PATH + '/variable', data: {"text": textInput.text});

      var data = VariableResponse.fromJson(res.data);
      funcName.value = data.funcName;
      Map<String, ItemTextController> mapList = {};

      data.data.forEach((va) {
        mapList[va.keys.toList()[0]] =
            ItemTextController(va.keys.toList()[0], TextEditingController());
      });

      mapVariable(mapList);
    } catch (err) {
      print(err.toString());
      running.value = false;
      Fluttertoast.showToast(
          msg: "Có lỗi xảy ra khi xử lý biến",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<void> handle() async {
    running.value = true;
    textHandle.value = "Thực thi...";
    await Future.delayed(Duration(seconds: 1));
    try {
      var dio = Dio();

      var mapRequest = {};
      mapVariable.forEach((key, itemC) {
        mapRequest[itemC.key] = itemC.textEditingController.text;
      });
      mapRequest["text"] =  textInput.text;

      print(mapRequest);
      var res = await dio.post(PATH + '/handle', data: mapRequest);

      var data = ExecuteResponse.fromJson(res.data);

      result(data.data.toString());
      textHandlePhp(data.textHandle);
    } catch (err) {
      print(err.toString());
      running.value = false;
      Fluttertoast.showToast(
          msg: "Có lỗi xảy ra khi xử lý biến",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    running.value = false;
  }
}

class ItemTextController {
  String key;
  TextEditingController textEditingController;

  ItemTextController(this.key, this.textEditingController);
}

class ExampleItem {
  String name;
  String text;

  ExampleItem({this.name, this.text});
}
