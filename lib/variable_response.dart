class VariableResponse {
  int code;
  bool success;
  String funcName;
  List<dynamic> data;

  VariableResponse({this.code, this.funcName, this.success, this.data});

  VariableResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    data = json['data'];
    funcName = json['func_name'];
  }
}

class ExecuteResponse {
  int code;
  bool success;
  String textHandle;
  dynamic data;

  ExecuteResponse({this.code, this.textHandle, this.success, this.data});

  ExecuteResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    data = json['data'];
    textHandle = json['text_handle'];
  }
}
