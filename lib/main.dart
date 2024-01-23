import 'package:flutter/material.dart';
import 'package:isolate_example/async_vs_isolate.dart';
import 'package:isolate_example/isolate_example_page.dart';
import 'package:isolate_example/simple_example.dart';

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
      home: SimpleIsolateExample(),
    );
  }
}

