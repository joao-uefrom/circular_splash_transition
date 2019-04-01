import 'package:circular_splash_transition/circular_splash.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  FirstScreen({Key key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  CircularSplashController _circularSplashController;

  @override
  void initState() {
    super.initState();
    _circularSplashController =
        CircularSplashController(color: Colors.cyanAccent);
  }

  @override
  void dispose() {
    _circularSplashController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CircularSplash(
      controller: _circularSplashController,
      child: Scaffold(
        backgroundColor: Colors.pink,
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          title: Text(
            "First Screen",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Now click the Floating Button to call a pushNamed.',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            String onWillPop =
                await _circularSplashController.pushNamed(context, "/second");
            print(onWillPop);
          },
          tooltip: 'pushNamed',
          child: Icon(Icons.forward),
        ),
      ),
    );
  }
}
