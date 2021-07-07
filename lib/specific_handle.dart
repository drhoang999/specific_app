import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';
import 'example.dart';

class SpecificHandleScreen extends StatelessWidget {
  SpecificHandleController specificHandleController =
      new SpecificHandleController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Text(
                'Bài mẫu',
              ),
              ...LIST_EXAMPLE
                  .map((e) => InkWell(
                onTap: () {
                  specificHandleController.mapVariable({});
                  specificHandleController.textInput.text = e.text;

                },
                    child: Container(
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.green)),
                          height: 110,
                          width: double.infinity,
                          child: Column(
                            children: [
                              Text(
                                e.name,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Divider(
                                color: Colors.grey,
                              ),
                              Expanded(
                                  child: SingleChildScrollView(
                                      child: Text(
                                e.text,
                                overflow: TextOverflow.ellipsis,
                              )))
                            ],
                          ),
                        ),
                  ))
                  .toList()
            ],
          ),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.backspace),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text("Biên dịch"),
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                TextFormField(
                  controller: specificHandleController.textInput,
                  minLines: 8, //Normal textInputField will be displayed
                  maxLines: 100,
                  keyboardType: TextInputType.multiline,
                  decoration:
                      InputDecoration(labelText: "Formal Specification"),
                ),
                Container(
                  constraints: BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                  margin: EdgeInsets.all(10),
                  child: RaisedButton(
                    onPressed: () {
                      specificHandleController.run();
                    },
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: EdgeInsets.all(0),
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Compiler',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Obx(
                  () => Column(
                    children: specificHandleController.mapVariable.keys.length >
                            0
                        ? [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Center(
                                  child: Text(
                                      "${specificHandleController.funcName}")),
                            ),
                            ...specificHandleController.mapVariable.values
                                .toList()
                                .map((element) => TextField(
                                      controller: element.textEditingController,
                                      decoration: InputDecoration(
                                          labelText: "Nhập ${element.key}"),
                                    ))
                                .toList(),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Row(
                                children: [
                                  Text("Kết quả: "),
                                  Text(
                                    " ${specificHandleController.result.value}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              constraints: BoxConstraints(
                                  maxWidth: 250.0, minHeight: 50.0),
                              margin: EdgeInsets.all(15),
                              child: RaisedButton(
                                onPressed: () {
                                  specificHandleController.handle();
                                },
                                color: Colors.green,
                                child: Padding(
                                  padding: EdgeInsets.all(0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Execute',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Text("Code php: "),
                            SizedBox(height: 10),
                            Text(specificHandleController.textHandlePhp.value ??
                                ""),
                          ]
                        : [],
                  ),
                )
              ],
            ),
          ),
        ),
        Obx(
          () => specificHandleController.running.value
              ? Center(
                  child: Container(
                    height: 100,
                    width: 200,
                    color: Colors.blue.withOpacity(0.6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          specificHandleController.textHandle.value ?? "",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
        )
      ]),
    );
  }
}
