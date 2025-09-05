import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Desktop/Screens/home_screen.dart';
import 'Desktop/Screens/splash_screen.dart';
import 'Desktop/Screens/login_screen.dart';
import 'Mobile/Splash_Screen/Splash.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.manropeTextTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[800],
            foregroundColor: Colors.white,
            textStyle: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.blue[800],
            side: BorderSide(color: Colors.blue[800]!),
            textStyle: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.blue[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.blue[800]!, width: 2),
          ),
          labelStyle: GoogleFonts.manrope(color: Colors.grey[600]),
          hintStyle: GoogleFonts.manrope(color: Colors.grey[500]),
        ),
      ),
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
    return const D_SplashScreen();
  }
}