import 'dart:isolate';

import 'package:flutter/material.dart';

class AsyncVSIsolate extends StatefulWidget {
  const AsyncVSIsolate({super.key});

  @override
  State<AsyncVSIsolate> createState() => _AsyncVSIsolateState();
}

class _AsyncVSIsolateState extends State<AsyncVSIsolate> {
  //source  https://www.youtube.com/watch?v=g6sPAWCFgtE

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Isolate VS Async"),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    useIsolate();
                    // runHeavyTaskWithoutIsolate(1000000000);
                  },
                  child: Text("Run Heavy Task"))
            ],
          ),
        ),
      ),
    );
  }

// do not use isolate here in class
}

// use isolate out of the class
useIsolate() async {
  final ReceivePort receivePort = ReceivePort();

  try {
    await Isolate.spawn(
        runHeavyTaskWithIsolate, [receivePort.sendPort, 1000000000]);
  } on Object {
    debugPrint("Isolate failed");
    receivePort.close();
  }
  final response = await receivePort.first;
  print("Result: $response");
}


int runHeavyTaskWithIsolate(List<dynamic> args) {
  SendPort resultPort = args[0];
  int value = 0;
  for(var i = 0 ; i<args[1] ; i++){
     value += i ;
  }
  Isolate.exit(resultPort , value);
}


int runHeavyTaskWithoutIsolate(int count) {
  int value = 0;
  for (var i = 0; i < count; i++) {
    value += 1;
  }
  print(value);
  return value;
}
