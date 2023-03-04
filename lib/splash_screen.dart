import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/home_screen.dart';
import 'package:http/http.dart' as http;
import 'common.dart';
import 'model_class/model_class.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      kBlurImage,
                    ))),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  klogoImage,
                  width: MediaQuery.of(context).size.width * .4,
                ),
                const SizedBox(height: 70),
                const CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.. turn on location');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      return Future.error(
          'Location permission denied forever,we cannot request');
    }

    currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    if (currentPosition != null) {
      currentLatitude = currentPosition?.latitude;
      currentLongitude = currentPosition?.longitude;

      final responseObj = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=$currentLatitude&lon=$currentLongitude&appid=710e3b7432b701de3cd910dd185a6ca0&units=metric'));
      if (responseObj.statusCode == 200) {
        Map<String, dynamic> responseResult = jsonDecode(responseObj.body);

        weatherObj = ModelClass.fromJson(responseResult);

        await Future.delayed(const Duration(seconds: 2));

        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
          return HomeScreen();
        }));
      }
    }
  }
}
