import 'package:circular_splash_transition/route.dart';
import 'package:flutter/material.dart';
import 'package:circular_splash_example/first_screen.dart';
import 'package:circular_splash_example/home_page.dart';
import 'package:circular_splash_example/second_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Circular Splash Transition',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(title: 'Circular Splash Transition Demo'),
      onGenerateRoute: (RouteSettings route) {
        switch (route.name) {
          case "/first":
            return CircularSplashRoute(
              builder: FirstScreen(),
              color: Colors.blue,
            );
          case "/second":
            return CircularSplashRoute(
              builder: SecondScreen(),
              color: Colors.cyanAccent,
            );
        }
      },
    );
  }
}
