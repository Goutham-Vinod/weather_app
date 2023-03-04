import 'package:flutter/material.dart';
import 'package:weather_app/home_screen.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/splash_screen.dart';

void main() {
  // to make status bar transparent
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor:
          Color.fromARGB(0, 0, 0, 0), // Set status bar color as transparent
      statusBarIconBrightness: Brightness.light, // Dark icon on status bar
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: SplashScreen(),
    );
  }
}
