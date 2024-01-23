import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WebComputeScreen extends StatefulWidget {
  const WebComputeScreen({super.key});

  @override
  State<WebComputeScreen> createState() => _WebComputeScreenState();
}

class _WebComputeScreenState extends State<WebComputeScreen> {
  String result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {
              performTimeConsumingTask();
            }, child: Text("do heavy web task")),
            CircularProgressIndicator(),
            Text(result)
          ],
        ),
      ),
    );
  }

  Future<void> performTimeConsumingTask() async {
    // Simulate a time-consuming task
    var result = await compute(backgroundTask, 100000000);
    setState(() {
      this.result = result;
    });
    print('Time-consuming task completed: $result');
  }

  String backgroundTask(int iterations) {
    // Simulate a time-consuming task
    var count = 0;
    for (int i = 0; i < iterations; i++) {
      count += i;
    }
    return count.toString();
  }
}
