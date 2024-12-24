import 'package:flutter/material.dart';
import 'package:calculator/services/remote_config_service.dart';

class ThemeViewModel extends ChangeNotifier {
  final RemoteConfigService _remoteConfig;
  late List<Color> _themeSeedColors;
  late int _seedColorIndex;
  late Brightness _brightness;

  ThemeViewModel(this._remoteConfig) {
    _themeSeedColors = _remoteConfig.themeSeedColors;
    _seedColorIndex = _remoteConfig.defaultThemeIndex;
    _brightness = _remoteConfig.defaultBrightness;
  }

  Color get seedColor => _themeSeedColors[_seedColorIndex];

  List<Color> get themeSeedColors => _themeSeedColors;

  int get seedColorIndex => _seedColorIndex;
  set seedColorIndex(int index) {
    _seedColorIndex = index;
    notifyListeners();
  }

  Brightness get brightness => _brightness;
  set brightness(Brightness value) {
    _brightness = value;
    notifyListeners();
  }
}