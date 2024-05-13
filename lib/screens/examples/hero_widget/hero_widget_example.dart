import "dart:math";

import "package:flutter/material.dart";

class HeroWidgetScreen extends StatelessWidget {
  const HeroWidgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hero Screen - 1"),
      ),
      body: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.all(10),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SecondScreen(),
                ),
              );
            },
            child: Hero(
              tag: "peick",
              transitionOnUserGestures: true,
              flightShuttleBuilder: (flightContext, animation, flightDirection,
                  fromHeroContext, toHeroContext) {
                final customAnimation = Tween<double>(
                  begin: 0,
                  end: 2,
                ).animate(animation);

                return AnimatedBuilder(
                  animation: customAnimation,
                  builder: (context, child) {
                    return Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.003)
                        ..rotateX(customAnimation.value * pi),
                      alignment: Alignment.center,
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        margin: const EdgeInsets.all(10),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Image.asset(
                          "assets/peick.webp",
                        ),
                      ),
                    );
                  },
                );
              },
              child: Image.asset(
                "assets/peick.webp",
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hero Screen - 2"),
      ),
      body: Container(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.all(10),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Hero(
          tag: "peick",
          transitionOnUserGestures: true,
          child: Image.asset(
            "assets/peick.webp",
          ),
        ),
      ),
    );
  }
}
