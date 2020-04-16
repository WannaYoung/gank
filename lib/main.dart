import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:gank/pages/splash/splash_page.dart';

void main() {
  runApp(
    MyApp()
  );
  // 设置 Android 状态栏透明
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '干货',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: SplashPage()
    );
  }
}
