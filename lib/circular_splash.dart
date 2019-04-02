import 'package:circular_splash_transition/route.dart';
import 'package:flutter/material.dart';
import 'dart:async';

// ignore: must_be_immutable
class CircularSplash extends StatefulWidget {
  CircularSplash(
      {Key key,
      @required this.controller,
      @required this.child,
      this.onWillPop})
      : assert(controller != null),
        assert(child != null),
        duration = controller.duration,
        color = controller.color,
        super(key: key) {
    if (onWillPop == null) {
      onWillPop = () => Future.value(true);
    }
  }

  final Duration duration;
  final Color color;
  final CircularSplashController controller;
  final Widget child;
  WillPopCallback onWillPop;

  @override
  _CircularSplashState createState() =>
      _CircularSplashState(controller, duration, color, onWillPop);
}

class _CircularSplashState extends State<CircularSplash>
    with SingleTickerProviderStateMixin {
  _CircularSplashState(
      this._controller, this._duration, this._color, this._onWillPop);

  final CircularSplashController _controller;
  final Duration _duration;
  final Color _color;
  final WillPopCallback _onWillPop;
  Animation<double> _animationScale;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _duration);
    _animationScale =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (_animationController.value > 0) {
          _controller.hasCancel = true;
          _controller.pushAndPopIn.add(false);
          return Future.value(false);
        } else {
          return _onWillPop();
        }
      },
      child: Stack(
        children: <Widget>[
          widget.child,
          StreamBuilder<bool>(
            stream: _controller.pushAndPopOut,
            initialData: false,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.data) {
                _animationController.forward();
              }
              if (!snapshot.data) {
                if (_animationController.value > 0) {
                  _animationController.reverse();
                }
              }
              return _pushAndPop();
            },
          ),
        ],
      ),
    );
  }

  Widget _pushAndPop() {
    return AnimatedBuilder(
        animation: _animationScale,
        builder: (context, child) {
          return Center(
            child: Transform.scale(
              scale: _animationScale.value * 2.5,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.height,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: _color),
              ),
            ),
          );
        });
  }
}

class CircularSplashController {
  final Duration duration;
  final Color color;
  bool hasCancel = false;
  bool hasRunning = false;

  CircularSplashController(
      {this.duration = const Duration(milliseconds: 300),
      this.color = Colors.white})
      : assert(color != null),
        assert(duration != null);

  void dispose() {
    _pushAndPopController?.close();
  }

  final StreamController<bool> _pushAndPopController = StreamController<bool>();

  Stream<bool> get pushAndPopOut => _pushAndPopController.stream;

  Sink<bool> get pushAndPopIn => _pushAndPopController.sink;

  Future<Object> _runPush(Function runPush) async {
    if (!hasRunning) {
      hasRunning = true;
      hasCancel = false;
      pushAndPopIn.add(true);
      await Future.delayed(Duration(milliseconds: duration.inMilliseconds + 1));
      if (hasCancel == true) {
        hasRunning = false;
        return null;
      }
      hasRunning = false;
      return runPush();
    } else {
      return null;
    }
  }

  void _runPop() async {
    await Future.delayed(Duration(milliseconds: duration.inMilliseconds + 1));
    pushAndPopIn.add(false);
  }

  Future<Object> pushNamed(BuildContext context, String routeName) {
    return _runPush(() {
      return Navigator.pushNamed(context, routeName).then((value) {
        _runPop();
        return value;
      });
    });
  }

  Future<Object> push(BuildContext context, Widget builder,
      {Color color = Colors.white,
      Duration duration = const Duration(milliseconds: 300)}) {
    return _runPush(() {
      return Navigator.push(
              context,
              CircularSplashRoute(
                  builder: builder, duration: duration, color: color))
          .then((value) {
        _runPop();
        return value;
      });
    });
  }

  void pushReplacement(BuildContext context, Widget builder,
      {Color color = Colors.white,
      Duration duration = const Duration(milliseconds: 300)}) {
    _runPush(() {
      Navigator.pushReplacement(
          context,
          CircularSplashRoute(
              builder: builder, duration: duration, color: color));
      dispose();
    });
  }

  void pushReplacementNamed(BuildContext context, String routeName) {
    _runPush(() {
      Navigator.pushReplacementNamed(context, routeName);
      dispose();
    });
  }
}
