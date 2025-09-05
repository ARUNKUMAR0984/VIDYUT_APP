import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'home_screen.dart';
import 'search_products_screen.dart';
import 'browse_brands_screen.dart';
import 'state_info_screen.dart';
import 'company_details_screen.dart';

class D_PowerGeneratorScreen extends StatefulWidget {
  const D_PowerGeneratorScreen({super.key});

  @override
  State<D_PowerGeneratorScreen> createState() => _D_PowerGeneratorScreenState();
}

class _D_PowerGeneratorScreenState extends State<D_PowerGeneratorScreen> {
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
                        backgroundColor: Colors.blue[600],
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Back Navigation
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const D_StateInfoScreen()),
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
                                'Back to Selection',
                                style: TextStyle(
                                  color: Colors.blue[600],
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Step Indicator
                        Row(
                          children: [
                            for (int i = 1; i <= 6; i++) ...[
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: i == 1 ? Colors.blue[600] : Colors.grey[300],
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '$i',
                                    style: TextStyle(
                                      color: i == 1 ? Colors.white : Colors.grey[600],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              if (i < 6) ...[
                                const SizedBox(width: 8),
                                Icon(
                                  Icons.chevron_right,
                                  color: Colors.grey[400],
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                              ],
                            ],
                          ],
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Title and Subtitle
                        const Text(
                          'Select Power Generator',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Choose the power generation company to proceed',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Main Content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 24,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: _getPowerGenerators().length,
                        itemBuilder: (context, index) {
                          return _buildPowerGeneratorCard(_getPowerGenerators()[index]);
                        },
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

  List<Map<String, dynamic>> _getPowerGenerators() {
    return [
      {
        'name': 'NTPC Limited',
        'type': 'Thermal',
        'capacity': '65,810 MW',
        'location': 'New Delhi',
        'units': '18,000+',
        'icon': Icons.power,
      },
      {
        'name': 'NHPC Limited',
        'type': 'Hydro',
        'capacity': '7,071 MW',
        'location': 'Faridabad',
        'units': '6,800+',
        'icon': Icons.water_drop,
      },
      {
        'name': 'Nuclear Power Corporation',
        'type': 'Nuclear',
        'capacity': '6,780 MW',
        'location': 'Mumbai',
        'units': '9,200+',
        'icon': Icons.science,
      },
      {
        'name': 'Adani Power',
        'type': 'Thermal',
        'capacity': '15,250 MW',
        'location': 'Ahmedabad',
        'units': '3,500+',
        'icon': Icons.power,
      },
      {
        'name': 'Tata Power',
        'type': 'Thermal',
        'capacity': '13,515 MW',
        'location': 'Mumbai',
        'units': '4,200+',
        'icon': Icons.power,
      },
    ];
  }

  Widget _buildPowerGeneratorCard(Map<String, dynamic> generator) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => D_CompanyDetailsScreen(company: generator),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(24),
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
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.blue[100],
                shape: BoxShape.circle,
              ),
              child: Icon(
                generator['icon'],
                color: Colors.blue[600],
                size: 40,
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Company Name
            Text(
              generator['name'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            
            const SizedBox(height: 8),
            
            // Type
            Text(
              generator['type'],
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Capacity
            Text(
              generator['capacity'],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[600],
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Location
            Text(
              generator['location'],
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Units
            Text(
              generator['units'],
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
