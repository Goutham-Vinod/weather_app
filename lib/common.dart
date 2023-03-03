import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

const kSunnyImageUrl =
    'https://media.istockphoto.com/id/1178574687/photo/blue-sky-and-white-clouds.jpg?s=612x612&w=0&k=20&c=ob8J6j3cPS-VC-Ia4zwDwvVPfxcqRKWB2uCpY6heVBU=';

const kCloudyImageUrl =
    'https://images.unsplash.com/photo-1532178910-7815d6919875?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y2xvdWR5JTIwc2t5fGVufDB8fDB8fA%3D%3D&w=1000&q=80';

const kRainyImageUrl =
    'https://images.news18.com/ibnlive/uploads/2021/07/1627056776_clouds-1600x900.jpg';

const kNightImageUrl =
    'https://w0.peakpx.com/wallpaper/111/665/HD-wallpaper-moon-night-sky.jpg';

String iconId = '10d';
String kIconUrlBase = 'http://openweathermap.org/img/wn/';
String kIconUrlEndpoint = '@2x.png';

const kSampleIconUrl = 'http://openweathermap.org/img/wn/10d@2x.png';

Position? currentPosition;
