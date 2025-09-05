import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'home_screen.dart';
import 'search_products_screen.dart';
import 'browse_brands_screen.dart';
import 'state_info_screen.dart';
import 'distribution_company_screen.dart';

class D_DistributionCompanyDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> company;
  
  const D_DistributionCompanyDetailsScreen({
    super.key,
    required this.company,
  });

  @override
  State<D_DistributionCompanyDetailsScreen> createState() => _D_DistributionCompanyDetailsScreenState();
}

class _D_DistributionCompanyDetailsScreenState extends State<D_DistributionCompanyDetailsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _sidebarSearchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    _sidebarSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 280,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                right: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: Column(
              children: [
                // Logo Section
                Container(
                  padding: const EdgeInsets.all(24),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue[600],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.flash_on,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Vidyut',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextField(
                    controller: _sidebarSearchController,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: const Icon(Ionicons.search_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                    ),
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Navigation Links
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildNavItem(Ionicons.home_outline, 'Home'),
                        _buildNavItem(Ionicons.search_outline, 'Search Products'),
                        _buildNavItem(Icons.branding_watermark, 'Browse Brands'),
                        _buildNavItem(Ionicons.bag_outline, 'My Orders', badge: '3'),
                        _buildNavItem(Ionicons.storefront_outline, 'Sell'),
                        _buildNavItem(Ionicons.chatbubbles_outline, 'Messages'),
                        _buildNavItem(Ionicons.location_outline, 'State Info', isActive: true),
                        _buildNavItem(Icons.trending_up, 'Trending'),
                        
                        const SizedBox(height: 30),
                        
                        // Account Section
                        _buildNavItem(Ionicons.settings_outline, 'Settings'),
                        _buildNavItem(Icons.help, 'Help'),
                      ],
                    ),
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
                        backgroundColor: Colors.red[600],
                        child: const Text(
                          'N',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'John Doe',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'john@example.com',
                              style: TextStyle(
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
            child: Container(
              color: Colors.grey[50],
              child: Column(
                children: [
                  // Header
                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey[300]!),
                      ),
                    ),
                    child: Row(
                      children: [
                        // Logo
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.purple[600],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.flash_on,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Vidyut',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                        ),
                        
                        const SizedBox(width: 20),
                        
                        // Main Search Bar
                        Expanded(
                          flex: 2,
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search products...',
                              prefixIcon: const Icon(Ionicons.search_outline),
                              suffixIcon: Container(
                                margin: const EdgeInsets.all(4),
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Icon(
                                  Ionicons.grid_outline,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                              filled: true,
                              fillColor: Colors.grey[50],
                            ),
                          ),
                        ),
                        
                        const SizedBox(width: 20),
                        
                        // Location
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Ionicons.location_outline, color: Colors.grey[600]),
                              const SizedBox(width: 8),
                              const Text('Deliver to: Set location'),
                            ],
                          ),
                        ),
                        
                        const SizedBox(width: 20),
                        
                        // Icons
                        IconButton(
                          icon: const Icon(Icons.notifications),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Ionicons.heart_outline_border),
                          onPressed: () {},
                        ),
                        
                        const SizedBox(width: 20),
                        
                        // Buttons
                        TextButton(
                          onPressed: () {},
                          child: const Text('Sign In'),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[600],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Sign Up'),
                        ),
                        
                        const SizedBox(width: 20),
                        
                        // User Avatar
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.blue[600],
                          child: const Text(
                            'JD',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Main Content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Top Navigation and Step Indicator
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Left Navigation
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const D_DistributionCompanyScreen(),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.arrow_back,
                                          color: Colors.blue[600],
                                          size: 20,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          '← Back',
                                          style: TextStyle(
                                            color: Colors.blue[600],
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 24),
                                                                     GestureDetector(
                                     onTap: () {
                                       Navigator.pushReplacement(
                                         context,
                                         MaterialPageRoute(
                                           builder: (context) => const D_StateInfoScreen(),
                                         ),
                                       );
                                     },
                                     child: Text(
                                       'Start Over',
                                       style: TextStyle(
                                         color: Colors.blue[600],
                                         fontSize: 16,
                                         fontWeight: FontWeight.w500,
                                         decoration: TextDecoration.underline,
                                       ),
                                     ),
                                   ),
                                ],
                              ),
                              
                              // Right Step Indicator
                              Row(
                                children: [
                                  for (int i = 1; i <= 6; i++) ...[
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: Colors.green[600], // All steps completed
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '$i',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (i < 6) ...[
                                      const SizedBox(width: 8),
                                    ],
                                  ],
                                ],
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 40),
                          
                          // Company Overview Card (Purple/Blue Gradient)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(40),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.purple[600]!,
                                  Colors.blue[600]!,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                // Company Logo Placeholder
                                Center(
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                  ),
                                ),
                                
                                const SizedBox(height: 24),
                                
                                // Company Name
                                Text(
                                  widget.company['name'],
                                  style: const TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                
                                const SizedBox(height: 16),
                                
                                // Subtitle
                                Text(
                                  'Leading electricity distribution company serving Mumbai with reliable power supply.',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white.withOpacity(0.9),
                                    height: 1.4,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                
                                const SizedBox(height: 32),
                                
                                // Information Tags
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _buildTag(Ionicons.location_outline, 'Mumbai Metropolitan Region'),
                                    const SizedBox(width: 16),
                                    _buildTag(Icons.people, '3.2 Million'),
                                    const SizedBox(width: 16),
                                    _buildTag(Icons.flash_on, '2,500 MW'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          
                          const SizedBox(height: 40),
                          
                          // Detailed Information Sections
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Left Column: Company Information
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(32),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        spreadRadius: 1,
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Title
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.business,
                                            color: Colors.blue[600],
                                            size: 24,
                                          ),
                                          const SizedBox(width: 12),
                                          const Text(
                                            'Company Information',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                      
                                      const SizedBox(height: 24),
                                      
                                      // Details
                                      _buildInfoRow(Icons.calendar_today, 'Established: 1905'),
                                      _buildInfoRow(Ionicons.location_outline, 'Address: Mumbai, Maharashtra, India'),
                                      _buildInfoRow(Icons.phone, 'Phone: +91-22-1234-5678'),
                                      _buildInfoRow(Icons.email, 'Email: info@mest.com'),
                                      _buildInfoRow(Icons.language, 'Website: www.mest.com'),
                                    ],
                                  ),
                                ),
                              ),
                              
                              const SizedBox(width: 24),
                              
                              // Right Column: Director Profile
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(32),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        spreadRadius: 1,
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Title
                                      Row(
                                        children: [
                                          Icon(
                                            Ionicons.person_outline,
                                            color: Colors.blue[600],
                                            size: 24,
                                          ),
                                          const SizedBox(width: 12),
                                          const Text(
                                            'Director Profile',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                      
                                      const SizedBox(height: 24),
                                      
                                      // Director Avatar
                                      Center(
                                        child: Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.grey[600],
                                            size: 40,
                                          ),
                                        ),
                                      ),
                                      
                                      const SizedBox(height: 16),
                                      
                                      // Director Name
                                      const Center(
                                        child: Text(
                                          'Mr. Rajesh Kumar',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                      
                                      const SizedBox(height: 8),
                                      
                                      // Director Title
                                      Center(
                                        child: Text(
                                          'Managing Director',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Show support dialog or navigate to support
        },
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        icon: const Icon(Icons.chat_bubble_outline),
        label: const Text('Support'),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String title, {bool isActive = false, String? badge}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Stack(
          children: [
            Icon(
              icon,
              color: isActive ? Colors.blue[600] : Colors.grey[600],
            ),
            if (badge != null)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
                  child: Text(
                    badge,
                    style: const TextStyle(
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
          style: TextStyle(
            color: isActive ? Colors.blue[600] : Colors.grey[600],
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        tileColor: isActive ? Colors.blue[50] : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        onTap: () {
          if (title == 'Home') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const D_HomeScreen()),
            );
          } else if (title == 'Search Products') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const D_SearchProductsScreen()),
            );
          } else if (title == 'Browse Brands') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const D_BrowseBrandsScreen()),
            );
          } else if (title == 'State Info') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const D_StateInfoScreen()),
            );
          }
        },
      ),
    );
  }

  Widget _buildTag(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.grey[600],
            size: 20,
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
