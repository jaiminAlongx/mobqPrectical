import 'dart:async';

import 'package:deemo/Home/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              child: Lottie.asset(
                'assets/logo.json',
                width: 200,
                height: 200,
                fit: BoxFit.fill,
              ),
            ),
            Text(
              "Find The Word !",
              style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * .05,
                  color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
