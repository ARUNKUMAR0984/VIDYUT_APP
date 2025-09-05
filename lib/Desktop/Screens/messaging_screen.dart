import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessagingScreen extends StatelessWidget {
  const MessagingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.message_outlined,
              size: 80,
              color: Colors.cyan[600],
            ),
            const SizedBox(height: 24),
            Text(
              'Messaging & Communications',
              style: GoogleFonts.manrope(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[900],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Send notifications, manage campaigns, and handle disputes',
              style: GoogleFonts.manrope(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildFeatureItem('Push Notifications', Icons.notifications),
                  _buildFeatureItem('Email Campaigns', Icons.email),
                  _buildFeatureItem('SMS Messaging', Icons.sms),
                  _buildFeatureItem('Buyer-Seller Chat Access', Icons.chat),
                  _buildFeatureItem('Geographic Campaigns', Icons.location_on),
                  _buildFeatureItem('Tier-based Messaging', Icons.layers),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.cyan[600], size: 20),
          const SizedBox(width: 12),
          Text(
            title,
            style: GoogleFonts.manrope(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
