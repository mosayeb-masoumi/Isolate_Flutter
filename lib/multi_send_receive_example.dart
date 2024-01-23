
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:isolate_example/once_send_receive_example_NEW_WAY.dart';

class MultiSendReceiveExample extends StatefulWidget {
  const MultiSendReceiveExample({super.key});

  @override
  State<MultiSendReceiveExample> createState() => _MultiSendReceiveExampleState();
}

class _MultiSendReceiveExampleState extends State<MultiSendReceiveExample> {


  // useful when you start downloading a file on a worker isolate and want to show the progress of the download on the UI.


  String count = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              print("isolate ${Isolate.current.debugName} start");
              startBackgroundIsolate();
            }, child: Text("do isolate")),

            const SizedBox(height: 10,),
            Text(count)

          ],
        ),
      ),
    );
  }
  void startBackgroundIsolate() async {
    ReceivePort receivePort = ReceivePort();
    print("send port is: ${receivePort.sendPort}");
    Isolate.spawn(backgroundTask, receivePort.sendPort);

    // Listen for messages from the background isolate
    receivePort.listen((message) {
      // receivePort.close();
      print('Received from background isolate: $message');

      setState(() {
        count = message.toString();
      });
    });
  }
}





Future<void> backgroundTask(SendPort sendPort) async {

  print("isolate ${Isolate.current.debugName} start ");
  // Your background task code goes here
  for (int i = 0; i < 5; i++) {
    print('Background Task: $i');
    sendPort.send("${i}");
    await Future.delayed(const Duration(seconds: 1));
  }

  print("isolate ${Isolate.current.debugName} finished ");
  // Send a message back to the main isolate

  sendPort.send("Background task completed");


  Isolate.exit();
}
