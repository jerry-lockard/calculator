import 'package:flutter/material.dart';
import 'package:calculator/screens/calculator_screen.dart';
import 'package:calculator/viewmodels/calculator_viewmodel.dart';
import 'package:calculator/viewmodels/theme_viewmodel.dart';
import 'package:calculator/services/remote_config_service.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/*************  ✨ Codeium Command ⭐  *************/
/// The entry point of the application.
///
/// This function initializes the Flutter framework and sets up the application
/// by loading the environment variables from the `.env` file, initializing
/// Firebase, setting up Crashlytics, and running the app with the necessary
/// providers.
/// ****  540e1cfc-9009-4ba5-81cc-5e96c299ce48  ******
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  try {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: dotenv.env['FIREBASE_API_KEY']!,
        authDomain: dotenv.env['FIREBASE_AUTH_DOMAIN']!,
        projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
        storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET']!,
        messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID']!,
        appId: dotenv.env['FIREBASE_APP_ID']!,
        measurementId: dotenv.env['FIREBASE_MEASUREMENT_ID']!,
      ),
    );

    // Initialize Firebase services
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

    // Initialize Remote Config
    final remoteConfig = await RemoteConfigService.initialize();

    // Set up Crashlytics
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => CalculatorViewModel(remoteConfig)),
          ChangeNotifierProvider(create: (_) => ThemeViewModel(remoteConfig)),
          Provider<FirebaseAnalytics>(
              create: (context) => FirebaseAnalytics.instance),
          Provider<FirebaseCrashlytics>(
              create: (context) => FirebaseCrashlytics.instance),
          Provider<RemoteConfigService>.value(value: remoteConfig),
        ],
        child: const CalculatorApp(),
      ),
    );
  } catch (e) {
    if (e.toString().contains('duplicate-app')) {
      // Firebase already initialized, continue
    } else {
      rethrow;
    }
  }
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override

  /// Builds the main application widget based on the theme from the
  /// [ThemeViewModel].
  ///
  /// This widget is the root of the application and is responsible for setting
  /// up the theme, title, and home widget.
  ///
  /// The theme is determined by the [ThemeViewModel] and is based on the
  /// application's current theme mode (light or dark) and the custom theme
  /// color seed.
  ///
  /// The home widget is the [CalculatorScreen] widget, which displays the
  /// calculator UI and handles user input.
  Widget build(BuildContext context) {
    var viewmodel = context.watch<ThemeViewModel>();

    return MaterialApp(
      title: 'Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Pretendard",
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: viewmodel.seedColor,
          brightness: viewmodel.brightness,
        ),
      ),
      home: const CalculatorScreen(),
    );
  }
}
