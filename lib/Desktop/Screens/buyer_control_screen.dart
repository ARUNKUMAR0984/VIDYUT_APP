import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuyerControlScreen extends StatelessWidget {
  const BuyerControlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_outline,
              size: 80,
              color: Colors.purple[600],
            ),
            const SizedBox(height: 24),
            Text(
              'Buyer Control Module',
              style: GoogleFonts.manrope(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[900],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Manage buyer accounts, profiles, and account actions',
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
                  _buildFeatureItem('View All Buyers', Icons.list),
                  _buildFeatureItem('Edit Buyer Profiles', Icons.edit),
                  _buildFeatureItem('Simulate Buyer Dashboard', Icons.dashboard),
                  _buildFeatureItem('Suspend/Ban Buyers', Icons.block),
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
          Icon(icon, color: Colors.purple[600], size: 20),
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
