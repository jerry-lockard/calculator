import 'dart:convert';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig;

  RemoteConfigService._(this._remoteConfig);

  /// Initializes RemoteConfig with defaults and fetches and activates the
  /// current config values.
  ///
  /// This must be called before using any other methods of [RemoteConfigService].
  ///
  /// The defaults are set to the following values:
  ///
  /// - `welcome_message`: "Welcome to Calculator!"
  /// - `theme_seed_colors`: ["#00BCD4", "#2196F3", "#9C27B0", "#E91E63", "#FF9800"]
  /// - `default_theme_index`: 0
  /// - `default_brightness`: "light"
  /// - `max_input_length`: 15
  /// - `max_decimal_length`: 5
  static Future<RemoteConfigService> initialize() async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));

    await remoteConfig.setDefaults({
      'welcome_message': 'Welcome to Calculator!',
      'theme_seed_colors':
          '["#00BCD4","#2196F3","#9C27B0","#E91E63","#FF9800"]',
      'default_theme_index': '0',
      'default_brightness': 'light',
      'max_input_length': '15',
      'max_decimal_length': '5',
    });

    await remoteConfig.fetchAndActivate();

    return RemoteConfigService._(remoteConfig);
  }

  String get welcomeMessage => _remoteConfig.getString('welcome_message');

  List<Color> get themeSeedColors {
    final colorsJson = _remoteConfig.getString('theme_seed_colors');
    final colorStrings = List<String>.from(jsonDecode(colorsJson));
    return colorStrings
        .map((colorString) =>
            Color(int.parse(colorString.replaceAll('#', '0xFF'))))
        .toList();
  }

  int get defaultThemeIndex =>
      int.parse(_remoteConfig.getString('default_theme_index'));

  Brightness get defaultBrightness =>
      _remoteConfig.getString('default_brightness') == 'light'
          ? Brightness.light
          : Brightness.dark;

  int get maxInputLength =>
      int.parse(_remoteConfig.getString('max_input_length'));

  int get maxDecimalLength =>
      int.parse(_remoteConfig.getString('max_decimal_length'));
}
