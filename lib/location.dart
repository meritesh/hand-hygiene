import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

double _userLongitude;
double _userLatitude;

void getUserLocation() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  _userLatitude = (prefs.getDouble('userlatitude') ?? 0);
  _userLongitude = (prefs.getDouble('userlongitude') ?? 0);
}

Future<Position> getLocation() async {
  getUserLocation();
  var geolocator = Geolocator();
  Position position;
  var locationOptions =
      LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

  geolocator.getPositionStream(locationOptions).listen((position) {
    getUserLocation();
    print(position == null
        ? 'Unknown'
        : position.latitude.toString() + ', ' + position.longitude.toString());

    distance1 = distance(new LatLng(_userLatitude, _userLongitude),
        new LatLng(position.latitude, position.longitude));
    print(distance1);
    if (!outOfHouse) {
      if (distance1 > 50) {
        outOfHouse = true;
        print('Come Back Soon');
      }
    } else {
      if (distance1 < 50) {
        outOfHouse = false;
        print('Welcome Home!');
      }
    }
  });
  return position;
}
