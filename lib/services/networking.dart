import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:clima/screens/loading_screen.dart';

class Networking {

  Networking({this.url});
  var url;

  Future getData() async {
    try {

      http.Response response = await http.get(url);

      var weatherData = response.body;
      print(response.statusCode);
      // var weatherCondition = jsonDecode(
      //     weatherData)['weather'][0]['description'];
      // var temperature = jsonDecode(weatherData)['main']['temp'];
      // var nameOfCity = jsonDecode(weatherData)['name'];
      // // print('Weather Condition: $weatherCondition');
      // // print('Weather Condition: ${temperature}');
      // // print('Weather Condition: $nameOfCity');
      return weatherData;
    }
    catch (e) {
      print(e);
    }
  }
}