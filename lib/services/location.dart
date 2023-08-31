import 'package:geolocator/geolocator.dart';

class Location {

  double? Latitude1;
  double? Longitude1;

  Future<void> getCurrentLocation()async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      Latitude1 = await position.latitude;
      Longitude1 = await position.longitude;
    }
    catch(e){
      print(e);
    }
  }
}
