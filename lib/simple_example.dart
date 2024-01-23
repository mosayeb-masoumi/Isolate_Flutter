
import 'dart:isolate';

import 'package:flutter/material.dart';

class SimpleIsolateExample extends StatefulWidget {
  const SimpleIsolateExample({super.key});

  @override
  State<SimpleIsolateExample> createState() => _SimpleIsolateExampleState();
}

class _SimpleIsolateExampleState extends State<SimpleIsolateExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: (){
          print("isolate ${Isolate.current.debugName} start");
          startBackgroundIsolate();
        }, child: Text("do isolate")),
      ),
    );
  }
  void startBackgroundIsolate() async {
    ReceivePort receivePort = ReceivePort();
    print("send port is: ${receivePort.sendPort}");
    Isolate.spawn(backgroundTask, receivePort.sendPort);

    // Listen for messages from the background isolate
    receivePort.listen((message) {
      print('Received from background isolate: $message');
    });
  }
}





Future<void> backgroundTask(SendPort sendPort) async {

  print("isolate ${Isolate.current.debugName} start ");
  // Your background task code goes here
  for (int i = 0; i < 5; i++) {
    print('Background Task: $i');
    await Future.delayed(const Duration(seconds: 1));
  }

  print("isolate ${Isolate.current.debugName} finished ");
  // Send a message back to the main isolate
  sendPort.send("Background task completed");
}
