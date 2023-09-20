import 'dart:isolate';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Isolate Example"),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 50,),
              ElevatedButton(
                  onPressed: () {
                    useIsolate();
                  },
                  child: const Text("Run Heavy Task"))
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
  for(var i = 0 ; i < args[1] ; i++){
    value += i ;
  }
  Isolate.exit(resultPort , value);
}
