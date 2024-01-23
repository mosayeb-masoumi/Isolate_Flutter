import 'package:flutter/material.dart';
import 'package:isolate_example/async_vs_isolate.dart';
import 'package:isolate_example/isolate_example_page.dart';
import 'package:isolate_example/multi_send_receive_example.dart';
import 'package:isolate_example/once_send_receive_example_NEW_WAY.dart';
import 'package:isolate_example/web_compute_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: AsyncVSIsolate(),
      // home: SimpleIsolateExample(),
      // home: OnceSendReceiveExample(),
      // home: MultiSendReceiveExample(),
      // home: HomePage(),
      home: WebComputeScreen(),
    );
  }
}

