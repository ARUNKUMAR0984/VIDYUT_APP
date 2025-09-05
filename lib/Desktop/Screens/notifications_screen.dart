import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications', style: GoogleFonts.manrope(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey[900],
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(child: ListTile(title: Text('Order #1001 shipped'), subtitle: Text('Track your package from Orders'))),
          SizedBox(height: 8),
          Card(child: ListTile(title: Text('Exclusive Offer'), subtitle: Text('10% OFF on LEDs this week'))),
        ],
      ),
    );
  }
}








