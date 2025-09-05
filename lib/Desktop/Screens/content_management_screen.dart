import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContentManagementScreen extends StatelessWidget {
  const ContentManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.content_copy_outlined,
              size: 80,
              color: Colors.teal[600],
            ),
            const SizedBox(height: 24),
            Text(
              'Content Management System',
              style: GoogleFonts.manrope(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[900],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Manage homepage content, static pages, and CMS',
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
                  _buildFeatureItem('Hero Slideshow Control', Icons.slideshow),
                  _buildFeatureItem('Homepage Sections', Icons.home),
                  _buildFeatureItem('Category Grid Management', Icons.grid_view),
                  _buildFeatureItem('Static Pages Editor', Icons.description),
                  _buildFeatureItem('State Info Database', Icons.location_on),
                  _buildFeatureItem('Blog/Announcements', Icons.article),
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
          Icon(icon, color: Colors.teal[600], size: 20),
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
