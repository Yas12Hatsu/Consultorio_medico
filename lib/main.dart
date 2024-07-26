import 'package:flutter/material.dart';
import 'package:wear/wear.dart';
import 'Pages/Login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WatchShape(
        builder: (BuildContext context, WearShape shape, Widget? child) {
          return AmbientMode(
            builder: (BuildContext context, WearMode mode, Widget? child) {
              return const Login();
            },
          );
        },
      ),
    );
  }
}