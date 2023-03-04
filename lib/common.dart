import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'model_class/model_class.dart';

const kSunnyImage = 'assets/sunnySky.jpg';

const kCloudyImage = 'assets/CloudyImg.jpg';

const kRainyImage = 'assets/RainyImg.jpg';

const kNightImage = 'assets/nightImg.jpg';

const kBlurImage = 'assets/blurImg.jpg';

String iconId = '10d';
String kIconUrlBase = 'http://openweathermap.org/img/wn/';
String kIconUrlEndpoint = '@2x.png';

const kSampleIconUrl = 'http://openweathermap.org/img/wn/10d@2x.png';

Position? currentPosition;

double? currentLatitude;
double? currentLongitude;

ModelClass? weatherObj;
