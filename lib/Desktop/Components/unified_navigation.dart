import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Screens/home_screen.dart';
import '../Screens/search_products_screen.dart';
import '../Screens/browse_brand_screen.dart';
import '../Screens/seller_dashboard_screen.dart';
import '../Screens/message_screen.dart';
import '../Screens/state_info_screen.dart';

class UnifiedNavigation extends StatelessWidget {
  final String currentPage;
  final bool isMobile;

  const UnifiedNavigation({
    super.key,
    required this.currentPage,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E293B).withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Logo
          Row(
            children: [
              Container(
                width: isMobile ? 32 : 40,
                height: isMobile ? 32 : 40,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF3B82F6).withOpacity(0.3),
                      spreadRadius: 0,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.flash_on,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Vidyut',
                style: GoogleFonts.manrope(
                  fontSize: isMobile ? 18 : 22,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          
          const Spacer(),
          
          // Navigation Items
          if (!isMobile) ...[
            _buildNavItem(context, 'Home', Ionicons.home_outline, 'home'),
            _buildNavItem(context, 'Search Products', Ionicons.search_outline, 'search'),
            _buildNavItem(context, 'Browse Brand', Icons.business, 'brand'),
            _buildNavItem(context, 'Seller', Ionicons.storefront_outline, 'seller'),
            _buildNavItem(context, 'Message', Ionicons.chatbubbles_outline, 'message'),
            _buildNavItem(context, 'State Info', Ionicons.location_outline, 'state'),
          ],
          
          // Mobile Menu Button
          if (isMobile)
            PopupMenuButton<String>(
              onSelected: (value) => _handleNavigation(context, value),
              itemBuilder: (BuildContext context) => [
                _buildPopupMenuItem('home', 'Home', Ionicons.home_outline),
                _buildPopupMenuItem('search', 'Search Products', Ionicons.search_outline),
                _buildPopupMenuItem('brand', 'Browse Brand', Icons.business),
                _buildPopupMenuItem('seller', 'Seller', Ionicons.storefront_outline),
                _buildPopupMenuItem('message', 'Message', Ionicons.chatbubbles_outline),
                _buildPopupMenuItem('state', 'State Info', Ionicons.location_outline),
              ],
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Ionicons.menu_outline,
                  color: Color(0xFF64748B),
                  size: 20,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String title, IconData icon, String page) {
    final isActive = currentPage == page;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: () => _handleNavigation(context, page),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF3B82F6).withOpacity(0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isActive ? const Color(0xFF3B82F6) : Colors.transparent,
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isActive ? const Color(0xFF3B82F6) : const Color(0xFF64748B),
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.manrope(
                  color: isActive ? const Color(0xFF3B82F6) : const Color(0xFF64748B),
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(String value, String title, IconData icon) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xFF64748B),
            size: 18,
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: GoogleFonts.manrope(
              color: const Color(0xFF1E293B),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  void _handleNavigation(BuildContext context, String page) {
    switch (page) {
      case 'home':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const D_HomeScreen()),
        );
        break;
      case 'search':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const D_SearchProductsScreen()),
        );
        break;
      case 'brand':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BrowseBrandScreen()),
        );
        break;
      case 'seller':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SellerDashboardScreen()),
        );
        break;
      case 'message':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MessageScreen()),
        );
        break;
      case 'state':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const D_StateInfoScreen()),
        );
        break;
    }
  }
}

