import 'dart:async';
import 'package:deemo/Home/binding.dart';
import 'package:deemo/approutes.dart';
import 'package:deemo/splashscren.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(168, 218, 220, 1),
      ),
      title: "",
      home: SplashScreen(),
      initialBinding: binding(),
      getPages: AppRoutes.pages,
      debugShowCheckedModeBanner: false,
    );
  }
}
