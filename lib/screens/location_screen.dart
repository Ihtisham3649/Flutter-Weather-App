import 'package:flutter/material.dart';
import '../utilities/constants.dart';
import 'dart:convert';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.weatherData});
  var weatherData;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  var weatherID;
  var temperature1;
  var nameOfCity;
  String? weatherConditionIcon;
  var getMessageAccordingWeather;
  var tem2;
  String? cityName;

  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    updateUI(widget.weatherData);
  }

  void updateUI(var weather) {
    setState(() {
      if (weather == null) {
        tem2 = 0;
        nameOfCity = '';
        weatherConditionIcon = 'Error';
        getMessageAccordingWeather = 'Unable to get weather data';
        return;
      }
      weatherID = jsonDecode(weather)['weather'][0]['id'];
      var temperature = jsonDecode(weather)['main']['temp'];
      var temperature1 = temperature!.toInt();
      tem2 = temperature1;
      nameOfCity = jsonDecode(weather)['name'];
      weatherConditionIcon = weatherModel.getWeatherIcon(weatherID);
      getMessageAccordingWeather = weatherModel.getMessage(temperature1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bg.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {

                      var weatherData = await weatherModel.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Column(
                      children: [
                        const Icon(
                          Icons.near_me,
                          size: 50.0,
                          color: Colors.white,
                        ),
                        Text('Update',
                            style: TextStyle(
                                fontFamily: 'Spartan MB', color: Colors.white)),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: ()async {
                      cityName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CityScreen(),
                        ),
                      );
                      if(cityName != null) {
                        var weatherData = await weatherModel.getCityWeather(cityName!);
                        updateUI(weatherData);
                      }
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.location_city,
                          size: 50.0,
                          color: Colors.white,
                        ),
                        Text('Cities',
                            style: TextStyle(
                                fontFamily: 'Spartan MB', color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$tem2°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherConditionIcon️',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$getMessageAccordingWeather in $nameOfCity",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// var weatherCondition = jsonDecode(weatherData)['weather'][0]['description'];
// var temperature = jsonDecode(weatherData)['main']['temp'];
// var nameOfCity = jsonDecode(weatherData)['name'];
