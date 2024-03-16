import 'package:flutter/material.dart';

class ColorProvider extends ChangeNotifier {
  Color _appTheme = Colors.deepPurple;
  bool _isLightMode = true;

  Color get appTheme => _appTheme;
  bool get isLightMode => _isLightMode;

  void updateFn(Color themeColor) {
    _appTheme = themeColor;
    notifyListeners();
  }

  void toggleBrightness(bool value) {
    _isLightMode = value;
    notifyListeners();
  }
}
