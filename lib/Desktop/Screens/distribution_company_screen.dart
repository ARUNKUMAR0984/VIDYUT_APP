import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'home_screen.dart';
import 'search_products_screen.dart';
import 'browse_brands_screen.dart';
import 'state_info_screen.dart';
import 'transmission_line_screen.dart';
import 'transmission_company_details_screen.dart';
import 'distribution_company_details_screen.dart';

class D_DistributionCompanyScreen extends StatefulWidget {
  const D_DistributionCompanyScreen({super.key});

  @override
  State<D_DistributionCompanyScreen> createState() => _D_DistributionCompanyScreenState();
}

class _D_DistributionCompanyScreenState extends State<D_DistributionCompanyScreen> {
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
                                      // Navigate back to Transmission Company Details (we'll need to pass some dummy data)
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => D_TransmissionCompanyDetailsScreen(
                                            company: {
                                              'name': 'Power Grid Corporation',
                                              'voltage': '765 kV',
                                              'type': 'National',
                                              'location': 'Gurugram',
                                              'connections': '12,500+',
                                            },
                                          ),
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
                                  Text(
                                    'Next: Final Review',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 16,
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
                                        color: i <= 5 ? Colors.green[600] : Colors.grey[300],
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '$i',
                                          style: TextStyle(
                                            color: i <= 5 ? Colors.white : Colors.grey[600],
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
                          
                          // Page Title
                          const Text(
                            'Select Distribution Company',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          
                          const SizedBox(height: 16),
                          
                          Text(
                            'Choose the distribution company (DISCOM)',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                          
                          const SizedBox(height: 40),
                          
                          // Distribution Company Options
                          Row(
                            children: [
                              // Left Card: Mumbai Electricity Supply & Transport
                              Expanded(
                                child: _buildDistributionCompanyCard(
                                  'Mumbai Electricity Supply & Transport',
                                  'Mumbai Metropolitan Region',
                                  '3.2 Million',
                                ),
                              ),
                              
                              const SizedBox(width: 24),
                              
                              // Right Card: Delhi Electricity Regulatory Commission
                              Expanded(
                                child: _buildDistributionCompanyCard(
                                  'Delhi Electricity Regulatory Commission',
                                  'National Capital Territory',
                                  '2.8 Million',
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

  Widget _buildDistributionCompanyCard(String title, String subtitle, String customerCount) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => D_DistributionCompanyDetailsScreen(
              company: {
                'name': title,
                'subtitle': subtitle,
                'customerCount': customerCount,
              },
            ),
          ),
        );
      },
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.purple[100],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.business,
                color: Colors.purple[600],
                size: 50,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Company Name
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            
            const SizedBox(height: 12),
            
            // Subtitle
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 20),
            
            // Customer Count Tag
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                customerCount,
                style: TextStyle(
                  color: Colors.blue[700],
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Sample data for distribution companies
final List<Map<String, dynamic>> distributionCompanies = [
  {
    'name': 'Mumbai Electricity Supply & Transport',
    'subtitle': 'Mumbai Metropolitan Region',
    'customerCount': '3.2 Million',
  },
  {
    'name': 'Delhi Electricity Regulatory Commission',
    'subtitle': 'National Capital Territory',
    'customerCount': '2.8 Million',
  },
];
