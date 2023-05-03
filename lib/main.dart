import 'package:flutter/material.dart';
import 'package:qr_akademiya/api_call.dart';
import 'package:qr_akademiya/first_screen.dart';
import 'package:qr_akademiya/login.dart';
import 'package:qr_akademiya/qr_scanner.dart';
import 'package:qr_akademiya/result_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
      title: 'Shayx akademiyasi',
      theme: ThemeData(
          appBarTheme:
              AppBarTheme(backgroundColor: Colors.transparent, elevation: 0.0)),
    );
  }
}
