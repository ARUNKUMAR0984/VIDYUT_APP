import 'package:flutter/material.dart';

import '../Screens/home_screen.dart';

class Splash_Screen extends StatelessWidget {
  const Splash_Screen({super.key});

  @override
  Widget build(BuildContext context) {
Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const M_HomeScreen()));
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body:Center(
        child: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.6,
            color: Colors.white,
            child: Image.asset('assets/Logo/3.png'),
          ),
      ),
    );
  }
}