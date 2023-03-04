import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:weather_app/common.dart';
import 'package:weather_app/home_page.dart';
import 'package:http/http.dart' as http;
import 'model_class/model_class.dart';

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
