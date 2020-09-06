import 'package:currency_converter_app/models/app_colors.dart';
import 'package:currency_converter_app/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 200,
            width: 200,
            child: Image.asset(
              'assets/images/splash_logo.png',
              fit: BoxFit.fill,
            ),
            decoration: BoxDecoration(shape: BoxShape.circle),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Launching App...',
            style: TextStyle(color: Colors.white, fontSize: 20),
          )
        ],
      )),
    );
  }
}
