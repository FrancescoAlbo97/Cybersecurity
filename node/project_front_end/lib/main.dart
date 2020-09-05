import 'package:flutter/material.dart';
import 'package:project_front_end/views/common/theme.dart';
import 'package:project_front_end/views/home/home.dart';
import 'package:project_front_end/views/login/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme,
      home: Home(),
    );
  }
}
