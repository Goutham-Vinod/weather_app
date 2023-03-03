import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:weather_app/common.dart';
import 'package:weather_app/model_class/model_class.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/widgets/details_text.dart';

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 80),
          Text(
            '${widget.weatherObj?.name}',
            style: TextStyle(color: Colors.white, fontSize: 35),
          ),
          //////////
        

          //////
          SizedBox(height: 130),
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
    );
  }
}
