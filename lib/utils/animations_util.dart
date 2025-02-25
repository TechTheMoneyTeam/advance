import 'package:flutter/material.dart';

class AnimationsUtils {
  static Route<T> createBottomToTopRoute<T>(Widget screen) {
    const begin = Offset(0.0, 1.0); // Start from bottom (0% x, 100% y)
    const end = Offset(0.0, 0.0); // End at normal position (0% x, 0% y)
    return _createAnimatedRoute(screen, begin, end);
  }
  
  static Route<T> _createAnimatedRoute<T>(Widget screen, Offset begin, Offset end) {
    return PageRouteBuilder<T>(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var curve = CurveTween(curve: Curves.easeInOut);
        var tween = Tween(begin: begin, end: end).chain(curve);
        var offsetAnimation = animation.drive(tween);
        
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
  
}