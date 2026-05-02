import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/splash_screen.dart';
import 'theme/cosmic_pulse_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: CosmicPulse.background,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const ApniSkoolApp());
}

class ApniSkoolApp extends StatelessWidget {
  const ApniSkoolApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalvi Supernova',
      debugShowCheckedModeBanner: false,
      theme: buildCosmicPulseTheme(),
      home: const SplashScreen(),
    );
  }
}
