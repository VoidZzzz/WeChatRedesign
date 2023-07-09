import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:we_chat/utils/error_widget.dart';
import 'package:we_chat/view/pages/auth/splash.dart';

void main() {
  ErrorWidget.builder = (FlutterErrorDetails detail) =>
      CustomErrorWidget(errorDetails: detail, oneTwoThree: 3);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'We Chat',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'Inter',
        fontFamilyFallback: const ['Pyidaungsu'],
        useMaterial3: true,
      ),
      home: const SplashScreenPage(),
    );
  }
}
