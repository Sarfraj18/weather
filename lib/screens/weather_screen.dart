import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/services/weather_service.dart';

import '../models/weather_model.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  //api key
  final _weatherService=WeatherService('912de0a534f675ba144a6a50e48eee4f');
  Weather? _weather;


  // fetch weather
  _fetchWeather()async{
    //get cureent  city
    String cityName=await _weatherService.getCurrentCity();

    //get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    //any error
    catch(e){
      print(e);
    }
  }


  //weather animations
  String getWeatherAnimation(String? mainCondition){
    if(mainCondition==null) return 'assets/icon/sunny2.json';// default to sunny


    switch(mainCondition.toLowerCase()){
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/icon/windly.json'  ;
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/icon/shower.json';
      case 'thunderstorm':
        return 'assets/icon/storm.json';
      case 'clear':
        return 'assets/icon/sunny2.json';
      default:
        return 'assets/icon/sunny2.json';



    }
  }

  //init state
  @override
  void initState() {
    _fetchWeather();
    super.initState();

  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center ,
          children: [
            //icon
            Icon(Icons.location_on),

            // city Name
            Text(_weather?.cityName ?? "loading city.."),

            //Animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

            //temperature
            Text('${_weather?.temperature.round()}°C'),

            // weather conditon
            Text(_weather?.mainCondition ?? "")
          ],
        ),
      ),

    );
  }
}
