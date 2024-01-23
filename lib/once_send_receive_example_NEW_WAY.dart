
import 'dart:isolate';

import 'package:flutter/material.dart';

class OnceSendReceiveExample extends StatefulWidget {
  const OnceSendReceiveExample({super.key});


  // this is new way of using isolate in flutter

  @override
  State<OnceSendReceiveExample> createState() => _OnceSendReceiveExampleState();
}

class _OnceSendReceiveExampleState extends State<OnceSendReceiveExample> {

  String result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () async {
              result = await startUsingRunMethod();
              setState(() {});
            }, child: Text("start Iosolate")),

            CircularProgressIndicator(color: Colors.red,),

            Text(result)

          ],
        ),


      ),
    );
  }

  Future<String> startUsingRunMethod() async {
    print("this isolate is ${Isolate.current.debugName}");
    final result = await Isolate.run(_readAndParseJsonWithoutIsolateLogic);
    print("this isolate is ${Isolate.current.debugName}");
    return result;
  }


}

Future<String> _readAndParseJsonWithoutIsolateLogic() async {

  // int count = 0;
  // for (int i = 1; i <= 10000; i++){
  //   count += i;
  // }
  // return count.toString();

  print("isolate ${Isolate.current.debugName} start ");
  await Future.delayed(const Duration(seconds: 2));
  print("isolate ${Isolate.current.debugName} finished ");
  return 'this is downloaded data';
}
