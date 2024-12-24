import 'package:flutter/material.dart';
import 'package:calculator/widgets/header_display.dart';
import 'package:calculator/widgets/input_pad.dart';
import 'package:calculator/widgets/theme_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:calculator/viewmodels/theme_viewmodel.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

const kSidePadding = 14.0;

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override

  /// The root widget of the calculator app.
  //
  /// This is a [Scaffold] with an app bar and a body. The app bar is a
  /// [ThemeAppBar], and the body is a [SafeArea] containing a
  /// [_buildBody] widget. The background color of the scaffold is set to the
  /// current seed color.
  //
  /// When the widget is first built, a post-frame callback is scheduled that
  /// shows a [SnackBar] with the welcome message from Remote Config.
  Widget build(BuildContext context) {
    var themeViewModel = context.watch<ThemeViewModel>();
    var remoteConfig = FirebaseRemoteConfig.instance;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(remoteConfig.getString('welcome_message'))),
      );
    });

    return Scaffold(
      appBar: ThemeAppBar.getAppBar(context),
      backgroundColor: themeViewModel.seedColor,
      body: SafeArea(
        child: _buildBody(),
      ),
    );
  }

  /// Builds the main body of the calculator app.
  ///
  /// This is a [Column] with three children. The first child is an
  /// [Expanded] widget containing a [HeaderDisplay] widget. The second
  /// child is an [InputPad] widget. The third child is a [SizedBox] with a
  /// height of [kSidePadding] to provide some extra space at the bottom of
  /// the screen.
  ///
  /// The column is padded with a horizontal padding of [kSidePadding] to
  /// provide some extra space on the left and right sides of the screen.
  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSidePadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Expanded(child: HeaderDisplay()),
          InputPad(),
          SizedBox(height: kSidePadding),
        ],
      ),
    );
  }
}
