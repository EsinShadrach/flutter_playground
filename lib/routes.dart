import "package:flutter/material.dart";
import "package:flutter_playground/main.dart";
import "package:flutter_playground/screens/animated_list/animated_list_example.dart";
import "package:flutter_playground/screens/jay/date_picker.dart";
import "package:flutter_playground/screens/page_animation/page_animation.dart";

mixin AppRoutes {
  static const String home = "/";
  static const String pageAnimation = "/page-animation";
  static const String animatdList = "/animated-list";
  static const String jay = "/jay";
}

Map<String, WidgetBuilder> routes() => {
      AppRoutes.home: (context) => const HomePage(),
      AppRoutes.pageAnimation: (context) => const PageAnimation(),
      AppRoutes.animatdList: (context) => const AnimatedListScreen(),
      AppRoutes.jay: (context) => const JayDatePicker(),
    };
