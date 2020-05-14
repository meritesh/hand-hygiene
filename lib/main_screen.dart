import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
//import 'location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      if (index == 2) {
        Navigator.pop(context);
        Navigator.pushNamed(context, '/profile');
      } else if (index == 1) {
        Navigator.pushNamed(context, '/washtimer');
      } else if (index == 0) {}
      print(index);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }

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
          : position.latitude.toString() +
              ', ' +
              position.longitude.toString());

      distance1 = distance(new LatLng(_userLatitude, _userLongitude),
          new LatLng(position.latitude, position.longitude));
      print(distance1);
      setState(() {
        if (!outOfHouse) {
          if (distance1 > 50) {
            outOfHouse = true;
            print('Come Back Soon');
          }
        } else {
          if (distance1 < 50) {
            outOfHouse = false;
            handsWashed = false;
            print('Welcome Home!');
          }
        }
      });
    });
    return position;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff00DEA1),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey.shade900,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            title: Text('Wash Timer'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.white,
        onTap: onItemTapped,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 150,
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35))),
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Card(
                    color: Colors.grey.shade900,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    child: Container(
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Icon(
                            outOfHouse ? Icons.directions_walk : Icons.home,
                            size: 80,
                            color: Color(0xff00DEA1),
                          ),
                          Text(
                            '${outOfHouse ? 'Come back soon' : 'You are back Home!'}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Card(
                    color: Colors.grey.shade900,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                              child: handsWashed
                                  ? null
                                  : Container(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Text(
                                              'You should wash your hands',
                                              style: TextStyle(fontSize: 24),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                OutlineButton(
                                                  color: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  onPressed: () {
                                                    Navigator.pushNamed(
                                                        context, '/washtimer');
                                                  },
                                                  child: Container(
                                                    child: Text('Wash Now'),
                                                  ),
                                                ),
                                                OutlineButton(
                                                  color: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  onPressed: () {
                                                    setState(() {
                                                      handsWashed = true;
                                                    });
                                                  },
                                                  child: Container(
                                                    child:
                                                        Text('Already Washed'),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
