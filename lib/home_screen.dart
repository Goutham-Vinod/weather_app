import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/common.dart';
import 'package:weather_app/home_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
          child: Image.asset(
            kSunnyImage,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        HomePage(weatherObj: weatherObj)
      ],
    ));
  }
}
