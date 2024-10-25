import 'package:geolocator/geolocator.dart';

Future<Position> _getUserLocation() async {
  return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
}
