import 'package:flutter/material.dart';

class CircularSplashRoute extends PageRouteBuilder {
  final Widget builder;
  final Color color;
  final Duration duration;

  @override
  Duration get transitionDuration => duration;

  CircularSplashRoute(
      {@required this.builder,
      this.color = Colors.white,
      this.duration = const Duration(milliseconds: 300)})
      : assert(color != null),
        assert(builder != null),
        assert(duration != null),
        super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return builder;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return Transition(
              color: color,
              animation: animation,
              widget: builder,
              context: context,
            );
          },
        );
}

class Transition extends StatelessWidget {
  final Animation<double> animation;
  final Widget widget;
  final BuildContext context;
  final Size size;
  final Animation<double> animationScale;
  final Color color;

  Transition(
      {@required this.animation,
      @required this.widget,
      @required this.context,
      @required this.color})
      : size = MediaQuery.of(context).size,
        animationScale = Tween<double>(begin: 1.0, end: 0.0).animate(animation);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget,
        AnimatedBuilder(
            animation: animationScale,
            builder: (context, child) {
              return Center(
                child: Transform.scale(
                  scale: animationScale.value * 2.5,
                  child: Container(
                    height: size.height,
                    width: size.height,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                    ),
                  ),
                ),
              );
            }),
      ],
    );
  }
}
