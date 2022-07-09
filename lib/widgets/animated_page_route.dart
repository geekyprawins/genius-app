import 'package:flutter/cupertino.dart';

class AnimatedPageRoute extends PageRouteBuilder {
  final Widget widget;
  AnimatedPageRoute(this.widget)
      : super(
          transitionDuration: Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secAnimation, child) {
            animation =
                CurvedAnimation(parent: animation, curve: Curves.easeIn);

            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.center,
            );
          },
          pageBuilder: (context, animation, secAnimation) {
            return widget;
          },
        );
}
