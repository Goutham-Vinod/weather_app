import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:weather_app/common.dart';
import 'package:weather_app/home_page.dart';
import 'package:http/http.dart' as http;
import 'functions.dart';
import 'model_class/model_class.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ModelClass? weatherObj;

  loadData() async {
    final responseObj = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${currentPosition?.latitude}&lon=${currentPosition?.longitude}&appid=710e3b7432b701de3cd910dd185a6ca0&units=metric'));
    if (responseObj.statusCode == 200) {
      Map<String, dynamic> responseResult = jsonDecode(responseObj.body);

      weatherObj = ModelClass.fromJson(responseResult);

      return weatherObj;

      // try {
      //   Map<String, dynamic> responseResult = jsonDecode(responseObj.body);

      //   weatherObj = ModelClass.fromJson(responseResult);

      //   return weatherObj;
      // } catch (e) {
      //   print(e);
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/vivid-blurred-colorful-wallpaper-background_58702-3798.jpg',
                    ))),
          ),
          ImageFiltered(
            imageFilter: ImageFilter.blur(
                sigmaY: 5,
                sigmaX: 5), //SigmaX and Y are just for X and Y directions
            child: Image.network(
              kSunnyImageUrl,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ), //here you can use any widget you'd like to blur .
          ),
          FutureBuilder(
            future: getLocation(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return FutureBuilder(
                  future: loadData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return HomePage(weatherObj: weatherObj);
                    } else {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Loading Api...',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CircularProgressIndicator(),
                          ],
                        ),
                      );
                    }
                  },
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Loading Location...',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CircularProgressIndicator(),
                    ],
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
