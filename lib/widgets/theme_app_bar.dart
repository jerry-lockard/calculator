import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calculator/viewmodels/theme_viewmodel.dart';
import 'package:provider/provider.dart';

class ThemeAppBar {
  /// Builds an app bar that allows the user to switch between light and dark theme
  /// and change the seed color of the theme.
  ///
  /// The app bar contains a row of buttons that represent the different seed
  /// colors supported by the app. The currently selected seed color is used to
  /// generate the theme's colors.
  ///
  /// The app bar also contains a switch that allows the user to switch between
  /// light and dark theme. The switch is displayed as a Cupertino-style switch
  /// and is colored according to the current theme.
  static AppBar getAppBar(BuildContext context) {
    var viewmodel = context.watch<ThemeViewModel>();

    return AppBar(
      actions: [
        Row(
          children: viewmodel.themeSeedColors
              .map((e) => _buildSeedColorButton(e, context))
              .toList(),
        ),
        const SizedBox(width: 10),
        const SizedBox(width: 10),
        CupertinoSwitch(
          value: viewmodel.brightness == Brightness.light,
          onChanged: (value) {
            viewmodel.brightness = value ? Brightness.light : Brightness.dark;
          },
          activeColor: Theme.of(context).colorScheme.primary,
          trackColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  /// Builds a small button that displays the given color and is used to set
  /// the seed color of the theme.
  ///
  /// The button is a small circle of the given color. When the button is tapped,
  /// the seed color of the theme is set to the given color.
  ///
  /// A small checkmark icon is displayed in the center of the button if the
  /// given color is the current seed color of the theme.
  ///
  /// The button is used in the app bar of the app and is one of a row of buttons
  /// that represent the different seed colors supported by the app.
  static Widget _buildSeedColorButton(Color color, BuildContext context) {
    var viewmodel = context.watch<ThemeViewModel>();
    return GestureDetector(
      onTap: () {
        viewmodel.seedColorIndex = viewmodel.themeSeedColors.indexOf(color);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: CircleAvatar(
          radius: 16,
          backgroundColor: color,
          child: viewmodel.seedColor == color
              ? const Icon(
                  Icons.check,
                  size: 16.0,
                  color: Colors.white,
                )
              : null,
        ),
      ),
    );
  }
}
