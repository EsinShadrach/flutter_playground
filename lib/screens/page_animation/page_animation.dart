import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef AnimationType = Offset;

class PageAnimation extends StatelessWidget {
  const PageAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (___, __, _) => const SecondScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  AnimationType begin = const Offset(0.0, 1.0);
                  AnimationType end = Offset.zero;

                  Animatable<AnimationType> tween =
                      Tween<AnimationType>(begin: begin, end: end).chain(
                    CurveTween(curve: Curves.easeInOut),
                  );

                  Animation<AnimationType> pageAnimation =
                      animation.drive(tween);

                  return SlideTransition(
                    position: pageAnimation,
                    child: child,
                  );
                },
              ),
            );
          },
          child: const Text('Go to Second Screen'),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text('Second Screen'),
        transitionBetweenRoutes: false,
      ),
      body: Center(
        child: Text('This is the Second Screen'),
      ),
    );
  }
}
