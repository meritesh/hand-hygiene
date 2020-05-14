//import 'package:geolocator/geolocator.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//import 'constants.dart';
//
//void setLocation() async {
//  List<Placemark> placemark;
//  Position position = await Geolocator()
//      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//  SharedPreferences prefs = await SharedPreferences.getInstance();
//  prefs.setDouble('userlongitude', position.longitude);
//  prefs.setDouble('userlatitude', position.latitude);
//  placemark = await Geolocator()
//      .placemarkFromCoordinates(position.latitude, position.longitude);
//  print(placemark[0].name);
//  placemarkData.add(placemark[0]);
//}
