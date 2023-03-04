import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:weather_app/common.dart';
import 'package:weather_app/home_screen.dart';
import 'package:weather_app/model_class/model_class.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/widgets/details_text.dart';
import 'package:geocoding/geocoding.dart';
import 'functions.dart';

class HomePage extends StatefulWidget {
  HomePage({required this.weatherObj, super.key});
  ModelClass? weatherObj;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  bool searchVisibility = false;
  TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 80),
            InkWell(
              child: Text(
                '${widget.weatherObj?.name}',
                style: TextStyle(color: Colors.white, fontSize: 35),
              ),
              onTap: () {
                setState(() {
                  searchVisibility = true;
                });
              },
            ),
            SizedBox(height: 20),
            Visibility(
              visible: searchVisibility,
              child: TextFormField(
                controller: searchTextController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    suffixIcon: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              findGeoLoc(searchTextController.text);
                            },
                            icon: Icon(
                              Icons.search,
                              color: Colors.white,
                            )),
                        IconButton(
                            onPressed: () {
                              searchTextController.clear();
                              setState(() {
                                searchVisibility = false;
                              });
                            },
                            icon: Icon(
                              Icons.clear,
                              color: Colors.white,
                            )),
                      ],
                    ),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.white)),
              ),
            ),
            //////
            SizedBox(height: 80),
            Row(
              children: [
                Text(
                  widget.weatherObj?.main?.temp?.toStringAsFixed(0) == null
                      ? '--'
                      : widget.weatherObj!.main!.temp!.toStringAsFixed(0),
                  style: TextStyle(color: Colors.white, fontSize: 70),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '°C',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      widget.weatherObj?.weather?[0].description == null
                          ? ''
                          : '${widget.weatherObj!.weather?[0].description}',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 10),
            Text(
              '${DateTime.now().day} ${DateTimeToMonth(DateTime.now())} ${DateTimeToWeekDay(DateTime.now())}',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    DetailsText(content: 'Feels like', size: 15),
                    DetailsText(
                        content:
                            '${widget.weatherObj?.main?.feelsLike?.toStringAsFixed(0)}°C',
                        size: 30),
                  ],
                ),
                Column(
                  children: [
                    DetailsText(content: 'Humidity', size: 15),
                    DetailsText(
                        content: '${widget.weatherObj?.main?.humidity}%',
                        size: 30),
                  ],
                ),
              ],
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    DetailsText(content: 'NNE Wind', size: 15),
                    DetailsText(
                        content:
                            '${((widget.weatherObj?.visibility)! / 1000).toStringAsFixed(0)} km/hr',
                        size: 20),
                  ],
                ),
                Column(
                  children: [
                    DetailsText(content: 'Max Temp', size: 15),
                    DetailsText(
                        content:
                            '${widget.weatherObj?.main?.tempMax?.toStringAsFixed(0)} °C',
                        size: 20),
                  ],
                ),
              ],
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    DetailsText(content: 'Visibility', size: 15),
                    DetailsText(
                        content:
                            '${((widget.weatherObj?.visibility)! / 1000).toStringAsFixed(0)} km',
                        size: 20),
                  ],
                ),
                Column(
                  children: [
                    DetailsText(content: 'Air pressure', size: 15),
                    DetailsText(
                        content:
                            '${widget.weatherObj?.main?.pressure.toString()} hPa',
                        size: 20),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  findGeoLoc(query) async {
    if (query != null) {
      List<Location> locations = await locationFromAddress(query);

      currentLatitude = locations[0].latitude;
      currentLongitude = locations[0].longitude;

      final responseObj = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=$currentLatitude&lon=$currentLongitude&appid=710e3b7432b701de3cd910dd185a6ca0&units=metric'));
      if (responseObj.statusCode == 200) {
        Map<String, dynamic> responseResult = jsonDecode(responseObj.body);

        weatherObj = ModelClass.fromJson(responseResult);
      }

      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
        return HomeScreen();
      }));
    } else {
      print('query is null');
    }
  }
}
