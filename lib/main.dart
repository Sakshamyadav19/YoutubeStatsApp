import 'package:flutter/material.dart';
import 'package:YTStats/YTStats.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "YTStats",
      theme: ThemeData(brightness:Brightness.dark),
      home: YTStats(),
    );
  }
}