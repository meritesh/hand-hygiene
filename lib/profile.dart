import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<Placemark> placemark;
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      if (index == 2) {
        Navigator.pop(context);
        Navigator.pushNamed(context, '/profile');
      } else if (index == 1) {
        Navigator.pushNamed(context, '/washtimer');
      } else if (index == 0) {
        Navigator.pop(context);
      }
      print(index);
    });
  }

  void setLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('userlongitude', position.longitude);
    prefs.setDouble('userlatitude', position.latitude);
    placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemark[0].name);
    print(placemark[0].subLocality);
    print(placemark[0].locality);
  }

  @override
  void initState() {
    super.initState();
    setLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            setLocation();
          });
        },
        child: Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: Text('Add Home Location'),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                leading: Icon(
                  Icons.home,
                  size: 40,
                ),
//        ${placemark[0].name} ${placemark[0].subLocality} ${placemark[0].locality}
                title: Text('Home'),
                subtitle: Text('Girija Society, Kothrud, Pune'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
