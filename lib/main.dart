import 'package:flutter/material.dart';
import 'package:handhygiene/profile.dart';
import 'package:handhygiene/test.dart';
import 'main_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hand Hygiene',
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xff00DEA1),
        backgroundColor: Colors.black,
      ),
      routes: {
        '/': (context) => MainScreen(),
        '/profile': (context) => Profile(),
        '/washtimer': (context) => CountDownTimer(),
      },
    );
  }
}
