import 'package:flutter/material.dart';
import 'package:flutter_playground/main.dart';
import 'package:flutter_playground/screens/page_animation/page_animation.dart';

mixin AppRoutes {
  static const String home = '/';
  static const String pageAnimation = '/page-animation';
}

Map<String, WidgetBuilder> routes = {
  AppRoutes.home: (context) => const HomePage(),
  AppRoutes.pageAnimation: (context) => const PageAnimation(),
};
