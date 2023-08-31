import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const weatherApiKey = 'dc985956a9b4c97aba959aaf8f3392cb';

class WeatherModel {

  Future<dynamic> getCityWeather(String nameOfCity) async{

    var url1 =
    Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$nameOfCity&appid=$weatherApiKey&units=metric');
    Networking networking = await Networking(url: url1 );
    var weatherData = await networking.getData();
    return weatherData;

  }

  Future<dynamic> getLocationWeather() async{
    Location location = Location();
    await location.getCurrentLocation();
    print('${location.Latitude1} ::: ${location.Longitude1}');
    var url1 =
    Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.Latitude1}&lon=${location.Longitude1}&appid=$weatherApiKey&units=metric');
    Networking networking = Networking(url: url1 );
    var weatherData = await networking.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
