import 'package:flutter/material.dart';
class D_HomeScreen extends StatefulWidget {
  const D_HomeScreen({super.key});

  @override
  State<D_HomeScreen> createState() => _D_HomeScreenState();
}

class _D_HomeScreenState extends State<D_HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Desktop Home Screen")),
    );
  }
}