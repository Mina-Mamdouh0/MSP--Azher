import 'package:msp/module/splashscreen.dart';
import 'package:msp/pages/home.dart';
import 'package:msp/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ui/app_theme.dart';

void main() {

  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(Splash()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "MSP Azhar",
        theme: ThemeData(
          brightness: Brightness.light,
          textTheme: AppTheme.textTheme,
          platform: TargetPlatform.iOS,
        ),
        onGenerateRoute: Rout.generateRoute,
      //  initialRoute: splash,
        home: Home()
    );
  }
}