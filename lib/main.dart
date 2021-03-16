import 'package:flutter/material.dart';
import 'screens/home/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      title: 'Hello World - Measure Converter',
      home: MyHomePage(title: 'Simple Converter')

      // debugShowMaterialGrid: true,
      // showSemanticsDebugger: true,
    );
  }
}
