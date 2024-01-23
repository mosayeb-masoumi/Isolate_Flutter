import 'dart:isolate';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  String result = "";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Isolate Example"),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () async {
                     result = await useIsolate();
                    setState(() {
                      
                    });
                  },
                  child: const Text("Run Heavy Task")),
              
              Text("result is ==> $result")

            ],
          ),
        ),
      ),
    );
  }

// do not use isolate here in class
}

// use isolate out of the class
Future<String> useIsolate() async {
  final ReceivePort receivePort = ReceivePort();

  try {
    await Isolate.spawn(
      runHeavyTaskWithIsolate,
      [receivePort.sendPort, 10000],
      errorsAreFatal: true,
      onExit: receivePort.sendPort,
      onError: receivePort.sendPort,
    );
  } on Object {
    debugPrint("Isolate failed");
    receivePort.close();
  }
  final response = await receivePort.first;
  print("Result: $response");
  if (response == null) {
    // this means the isolate exited without sending any results
    // TODO throw error
    return 'No message';
  } else if (response is List) {
    // if the response is a list, this means an uncaught error occurred
    final errorAsString = response[0];
    final stackTraceAsString = response[1];
    // TODO throw error
    return 'Uncaught Error';
  } else {
    return response as String;
  }
}

int runHeavyTaskWithIsolate(List<dynamic> args) {
  SendPort resultPort = args[0];
  int value = 0;
  for (var i = 0; i < args[1]; i++) {
    value += i;
  }
  Isolate.exit(resultPort, value.toString());
}
