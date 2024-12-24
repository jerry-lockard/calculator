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