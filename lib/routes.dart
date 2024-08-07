import "package:flutter/material.dart";
import "package:flutter_playground/main.dart";
import "package:flutter_playground/screens/animated_list/animated_list_example.dart";
import "package:flutter_playground/screens/examples/hero_widget/hero_widget_example.dart";
import "package:flutter_playground/screens/examples/overlay_example/overlay_example_screen.dart";
import "package:flutter_playground/screens/examples/scale_down_btn/scale_down_btn_example.dart";
import "package:flutter_playground/screens/page_animation/page_animation.dart";
import "package:flutter_playground/screens/stacks/stacked_cards.dart";
import "package:flutter_playground/screens/sticky_header/sticky_header_screen.dart";
import "package:flutter_playground/screens/top_snackbar/top_snackbar.dart";

mixin AppRoutes {
  static const String home = "/";
  static const String pageAnimation = "/page-animation";
  static const String animatdList = "/animated-list";
  static const String scaleDownOnPressed = "/scale-down-on-pressed-btn";
  static const String overlayExample = "/overlay-example";
  static const String heroWidget = "/hero-widget";
  static const String topSnackbar = "/top-snackbar";
  static const String stack = "/stack";
  static const String stickerHeader = "/sticky-header";
}

Map<String, WidgetBuilder> routes() => {
      AppRoutes.home: (context) => const HomePage(),
      AppRoutes.pageAnimation: (context) => const PageAnimation(),
      AppRoutes.animatdList: (context) => const AnimatedListScreen(),
      AppRoutes.scaleDownOnPressed: (context) => const ScaleDownButton(),
      AppRoutes.overlayExample: (context) => const OverlayScreenExample(),
      AppRoutes.heroWidget: (context) => const HeroWidgetScreen(),
      AppRoutes.topSnackbar: (context) => const TopSnackbar(),
      AppRoutes.stack: (context) => const StackedCards(),
      AppRoutes.stickerHeader: (context) => const StickyHeaderScreen(),
    };
