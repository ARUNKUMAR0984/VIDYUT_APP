import 'package:flutter/material.dart';
import 'package:vidyut_app/Desktop/Screens/home_screen.dart';
import 'package:vidyut_app/Mobile/Splash_Screen/Splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Responsive_Screen(),
    );
  }
}


class Responsive_Screen extends StatelessWidget {
  const Responsive_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return const Splash_Screen();
    }
    return const D_HomeScreen();

  }
}