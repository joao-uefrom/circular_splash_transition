import 'package:circular_splash_transition/circular_splash.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CircularSplashController _circularSplashController;

  @override
  void initState() {
    super.initState();
    _circularSplashController = CircularSplashController(color: Colors.blue);
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
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Click the Floating Button to call a pushReplacementNamed.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _circularSplashController.pushReplacementNamed(context, "/first");
          },
          tooltip: 'pushReplacementNamed',
          child: Icon(Icons.forward),
        ),
      ),
    );
  }
}
