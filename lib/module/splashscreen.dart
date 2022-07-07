import 'package:flutter/material.dart';
import 'package:msp/main.dart';
import 'package:splashscreen/splashscreen.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(
          loaderColor: Colors.red,
          backgroundColor: Colors.white60,
          title: Text('MSP Azhar University',style: TextStyle(
            color: Colors.black,
            fontSize: 20
          ),),
          image:Image.asset("assets/images/msp_logo.png"),
          loadingText: Text('Welcome To Application'),
           photoSize: 100.0,
          seconds: 5,
         navigateAfterSeconds: MyApp(),
        ),
    );
  }
}
