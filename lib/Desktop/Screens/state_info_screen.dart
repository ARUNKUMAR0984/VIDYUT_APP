import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';
import 'search_products_screen.dart';
import 'browse_brands_screen.dart';
import 'power_generator_screen.dart';
import 'select_state_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'cart_screen.dart';
import 'wishlist_screen.dart';

class D_StateInfoScreen extends StatefulWidget {
  const D_StateInfoScreen({super.key});

  @override
  State<D_StateInfoScreen> createState() => _D_StateInfoScreenState();
}

class _D_StateInfoScreenState extends State<D_StateInfoScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _sidebarSearchController = TextEditingController();
  bool _isSidebarVisible = true;

  @override
  void dispose() {
    _searchController.dispose();
    _sidebarSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          // Left Sidebar Navigation
          if (_isSidebarVisible)
            Container(
              width: 280,
              color: Colors.white,
              child: Column(
                children: [
                  // Logo Section
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.blue[800],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.flash_on,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Vidyut',
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: _sidebarSearchController,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: GoogleFonts.inter(color: Colors.grey[500]),
                        prefixIcon: const Icon(Icons.search, color: Colors.grey),
                        suffixIcon: Container(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            '⌘K',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.blue[800]!, width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Navigation Links
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      children: [
                        _buildNavItem(Icons.home, 'Home'),
                        _buildNavItem(Icons.search, 'Search Products'),
                        _buildNavItem(Icons.business, 'Browse Brands'),
                        _buildNavItem(Icons.shopping_bag, 'My Orders', badge: '3'),
                        _buildNavItem(Icons.store, 'Sell'),
                        _buildNavItem(Icons.message, 'Messages'),
                        _buildNavItem(Icons.location_on, 'State Info', isActive: true),
                        _buildNavItem(Icons.trending_up, 'Trending'),
                        const Divider(height: 32),
                        _buildNavItem(Icons.settings, 'Settings'),
                        _buildNavItem(Icons.help, 'Help'),
                      ],
                    ),
                  ),
                  
                  // User Profile
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.grey[300]!),
                      ),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.blue[100],
                          child: Text(
                            'JD',
                            style: GoogleFonts.inter(
                              color: Colors.blue[800],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'John Doe',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'john.doe@example.com',
                                style: GoogleFonts.inter(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          
          // Main Content
          Expanded(
            child: Column(
              children: [
                // Top Header
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[200]!),
                    ),
                  ),
                  child: Row(
                    children: [
                      // Menu Toggle Button
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _isSidebarVisible = !_isSidebarVisible;
                          });
                        },
                        icon: Icon(
                          _isSidebarVisible ? Icons.menu_open : Icons.menu,
                          color: Colors.blue[800],
                          size: 24,
                        ),
                      ),
                      
                      const SizedBox(width: 16),
                      
                      // Logo
                      Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.blue[800],
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(
                              Icons.flash_on,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Vidyut',
                            style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800],
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(width: 40),
                      
                      // Search Bar
                      Expanded(
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 600),
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search state information...',
                              hintStyle: GoogleFonts.inter(color: Colors.grey[500]),
                              prefixIcon: const Icon(Icons.search, color: Colors.grey),
                              suffixIcon: Container(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  '⌘K',
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.blue[800]!, width: 2),
                              ),
                              filled: true,
                              fillColor: Colors.grey[50],
                            ),
                          ),
                        ),
                      ),
                      
                      const SizedBox(width: 20),
                      
                      // Right Side Actions
                      Row(
                        children: [
                          // Location
                          Row(
                            children: [
                              const Icon(Icons.location_on, color: Colors.grey, size: 20),
                              const SizedBox(width: 4),
                              Text(
                                'Deliver to: Set location',
                                style: GoogleFonts.inter(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          
                          const SizedBox(width: 20),
                          
                          // Notifications
                          IconButton(
                            icon: const Icon(Icons.notifications_outlined, color: Colors.grey),
                            onPressed: () {},
                          ),
                          
                          // Wishlist
                          IconButton(
                            icon: const Icon(Icons.favorite_border, color: Colors.grey),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const WishlistScreen()),
                              );
                            },
                          ),
                          
                          const SizedBox(width: 16),
                          
                          // Sign In
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginScreen()),
                              );
                            },
                            child: Text(
                              'Sign In',
                              style: GoogleFonts.inter(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          
                          const SizedBox(width: 12),
                          
                          // Sign Up Button
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const RegisterScreen()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[800],
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Sign Up',
                              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                            ),
                          ),
                          
                          const SizedBox(width: 16),
                          
                          // User Avatar
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.blue[100],
                            child: Text(
                              'JD',
                              style: GoogleFonts.inter(
                                color: Colors.blue[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Main Content Area
                Expanded(
                  child: Container(
                    color: Colors.grey[50],
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title Section
                          Text(
                            'State Electricity Board Information',
                            style: GoogleFonts.inter(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[900],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Access comprehensive information about electricity boards, power generation, and distribution across different states',
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              color: Colors.grey[600],
                              height: 1.5,
                            ),
                          ),
                          
                          const SizedBox(height: 60),
                          
                          // Two Main Cards
                          Row(
                            children: [
                              // Left Card: Power Generation Flow
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const D_PowerGeneratorScreen()),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(32),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: Colors.grey[200]!),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Icon Circle
                                        Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            color: Colors.blue[800],
                                            borderRadius: BorderRadius.circular(40),
                                          ),
                                          child: const Icon(
                                            Icons.power_settings_new,
                                            color: Colors.white,
                                            size: 40,
                                          ),
                                        ),
                                        
                                        const SizedBox(height: 24),
                                        
                                        // Title
                                        Text(
                                          'Power Generation Flow',
                                          style: GoogleFonts.inter(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[900],
                                          ),
                                        ),
                                        
                                        const SizedBox(height: 16),
                                        
                                        // Description
                                        Text(
                                          'Explore the complete power supply chain from generation to distribution',
                                          style: GoogleFonts.inter(
                                            fontSize: 16,
                                            color: Colors.grey[600],
                                            height: 1.5,
                                          ),
                                        ),
                                        
                                        const SizedBox(height: 24),
                                        
                                        // Flow Path
                                        Row(
                                          children: [
                                            Text(
                                              'Generator',
                                              style: GoogleFonts.inter(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.blue[700],
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Icon(Icons.arrow_forward, color: Colors.blue[700], size: 16),
                                            const SizedBox(width: 8),
                                            Text(
                                              'Transmission',
                                              style: GoogleFonts.inter(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.blue[700],
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Icon(Icons.arrow_forward, color: Colors.blue[700], size: 16),
                                            const SizedBox(width: 8),
                                            Text(
                                              'Distribution',
                                              style: GoogleFonts.inter(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.blue[700],
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Icon(Icons.arrow_forward, color: Colors.blue[700], size: 16),
                                            const SizedBox(width: 8),
                                            Text(
                                              'Consumer',
                                              style: GoogleFonts.inter(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.blue[700],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              
                              const SizedBox(width: 32),
                              
                              // Right Card: State-Based Flow
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const D_SelectStateScreen()),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(32),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: Colors.grey[200]!),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.05),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Icon Circle
                                        Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            color: Colors.green[600],
                                            borderRadius: BorderRadius.circular(40),
                                          ),
                                          child: const Icon(
                                            Icons.map_outlined,
                                            color: Colors.white,
                                            size: 40,
                                          ),
                                        ),
                                        
                                        const SizedBox(height: 24),
                                        
                                        // Title
                                        Text(
                                          'State-Based Flow',
                                          style: GoogleFonts.inter(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey[900],
                                          ),
                                        ),
                                        
                                        const SizedBox(height: 16),
                                        
                                        // Description
                                        Text(
                                          'Browse electricity information by state and explore mandal-level details',
                                          style: GoogleFonts.inter(
                                            fontSize: 16,
                                            color: Colors.grey[600],
                                            height: 1.5,
                                          ),
                                        ),
                                        
                                        const SizedBox(height: 24),
                                        
                                        // Flow Path
                                        Row(
                                          children: [
                                            Text(
                                              'State',
                                              style: GoogleFonts.inter(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.green[700],
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Icon(Icons.arrow_forward, color: Colors.green[700], size: 16),
                                            const SizedBox(width: 8),
                                            Text(
                                              'Districts',
                                              style: GoogleFonts.inter(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.green[700],
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Icon(Icons.arrow_forward, color: Colors.green[700], size: 16),
                                            const SizedBox(width: 8),
                                            Text(
                                              'Mandal',
                                              style: GoogleFonts.inter(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.green[700],
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Icon(Icons.arrow_forward, color: Colors.green[700], size: 16),
                                            const SizedBox(width: 8),
                                            Text(
                                              'Village',
                                              style: GoogleFonts.inter(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.green[700],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 60),
                          
                          // Additional Information Section
                          Container(
                            padding: const EdgeInsets.all(32),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.grey[200]!),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.info_outline,
                                      color: Colors.blue[800],
                                      size: 24,
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      'Quick Information',
                                      style: GoogleFonts.inter(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[900],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildInfoItem(
                                        'Total States',
                                        '28 + 8 UTs',
                                        Icons.location_city,
                                        Colors.blue[100]!,
                                        Colors.blue[800]!,
                                      ),
                                    ),
                                    const SizedBox(width: 32),
                                    Expanded(
                                      child: _buildInfoItem(
                                        'Power Plants',
                                        '1,200+',
                                        Icons.power,
                                        Colors.green[100]!,
                                        Colors.green[600]!,
                                      ),
                                    ),
                                    const SizedBox(width: 32),
                                    Expanded(
                                      child: _buildInfoItem(
                                        'Distribution Companies',
                                        '60+',
                                        Icons.business,
                                        Colors.orange[100]!,
                                        Colors.orange[600]!,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String title, {bool isActive = false, String? badge}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Stack(
          children: [
            Icon(
              icon,
              color: isActive ? Colors.blue[800] : Colors.grey[600],
              size: 24,
            ),
            if (badge != null)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red[500],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    badge,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
        title: Text(
          title,
          style: GoogleFonts.inter(
            color: isActive ? Colors.blue[800] : Colors.grey[700],
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
        tileColor: isActive ? Colors.blue[50] : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        onTap: () {
          if (title == 'Home') {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const D_HomeScreen()),
              (route) => false,
            );
          } else if (title == 'Search Products') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const D_SearchProductsScreen()),
            );
          } else if (title == 'Browse Brands') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const D_BrowseBrandsScreen()),
            );
          }
        },
      ),
    );
  }

  Widget _buildInfoItem(String title, String value, IconData icon, Color bgColor, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 32,
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
