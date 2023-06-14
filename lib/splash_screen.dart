import 'dart:async';

import 'package:chat_gpt_02/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to the next screen after a delay
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, ChatScreen.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          'assets/image.svg',
          width: 300,
          height: 300,
          semanticsLabel: 'Splash Screen',
          placeholderBuilder: (BuildContext context) =>
              CircularProgressIndicator(),
        ),
      ),
    );
  }
}
