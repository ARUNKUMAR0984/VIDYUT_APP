import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'search_products_screen.dart';
import 'browse_brands_screen.dart';
import 'state_details_screen.dart';
import 'city_details_screen.dart';

class D_DistrictsMandalsScreen extends StatefulWidget {
  final Map<String, String> stateData;
  
  const D_DistrictsMandalsScreen({super.key, required this.stateData});

  @override
  State<D_DistrictsMandalsScreen> createState() => _D_DistrictsMandalsScreenState();
}

class _D_DistrictsMandalsScreenState extends State<D_DistrictsMandalsScreen> {
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
                      prefixIcon: const Icon(Icons.search),
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
                        _buildNavItem(Icons.home, 'Home'),
                        _buildNavItem(Icons.search, 'Search Products'),
                        _buildNavItem(Icons.branding_watermark, 'Browse Brands'),
                        _buildNavItem(Icons.shopping_bag, 'My Orders', badge: '3'),
                        _buildNavItem(Icons.store, 'Sell'),
                        _buildNavItem(Icons.message, 'Messages'),
                        _buildNavItem(Icons.location_on, 'State Info', isActive: true),
                        _buildNavItem(Icons.trending_up, 'Trending'),
                        
                        const SizedBox(height: 30),
                        
                        // Account Section
                        _buildNavItem(Icons.settings, 'Settings'),
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
                          'JD',
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
              color: Colors.white,
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
                            color: Colors.blue,
                          ),
                        ),
                        
                        const SizedBox(width: 20),
                        
                        // Back Arrow
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        
                        const SizedBox(width: 20),
                        
                        // Main Search Bar
                        Expanded(
                          flex: 2,
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Search products...',
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: Container(
                                margin: const EdgeInsets.all(4),
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Icon(
                                  Icons.grid_view,
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
                              Icon(Icons.location_on, color: Colors.grey[600]),
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
                          icon: const Icon(Icons.favorite_border),
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
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => D_StateDetailsScreen(stateData: widget.stateData),
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
                                      '← Back to ${widget.stateData['name']}',
                                      style: TextStyle(
                                        color: Colors.blue[600],
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              // Right Step Indicator
                              Row(
                                children: [
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: Colors.green[600], // Step 1 completed
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(Icons.arrow_forward, color: Colors.grey[400], size: 20),
                                  const SizedBox(width: 8),
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: Colors.green[600], // Step 2 completed
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(Icons.arrow_forward, color: Colors.grey[400], size: 20),
                                  const SizedBox(width: 8),
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: Colors.green[600], // Step 3 active
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        '3',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 40),
                          
                          // Banner Placeholder
                          Container(
                            width: double.infinity,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                color: Colors.grey[400],
                                size: 32,
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 40),
                          
                          // Page Title
                          Row(
                            children: [
                              Icon(
                                Icons.home,
                                color: Colors.blue[600],
                                size: 28,
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Districts & Mandals',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 40),
                          
                          // Districts Grid
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1.1,
                              crossAxisSpacing: 24,
                              mainAxisSpacing: 24,
                            ),
                            itemCount: _getStateDistricts(widget.stateData['name']!).length,
                            itemBuilder: (context, index) {
                              final district = _getStateDistricts(widget.stateData['name']!)[index];
                              return _buildDistrictCard(district);
                            },
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
          }
        },
      ),
    );
  }

  Widget _buildDistrictCard(Map<String, String> district) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => D_CityDetailsScreen(
              stateData: widget.stateData,
              cityData: district,
            ),
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
                color: Colors.green[100],
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.home,
                color: Colors.green,
                size: 40,
              ),
            ),
            
            const SizedBox(height: 20),
            
            // District Name
            Text(
              district['name']!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            
            const SizedBox(height: 12),
            
            // Population
            Text(
              '${district['population']} Million',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            
            const SizedBox(height: 16),
            
            // Power Capacity
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${district['capacity']} MW',
                style: TextStyle(
                  color: Colors.blue[700],
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to get districts for each state
  List<Map<String, String>> _getStateDistricts(String stateName) {
    switch (stateName) {
      case 'Maharashtra':
        return [
          {'name': 'Mumbai City', 'population': '12.5', 'capacity': '2,800'},
          {'name': 'Pune', 'population': '6.2', 'capacity': '1,200'},
          {'name': 'Nagpur', 'population': '3.1', 'capacity': '650'},
          {'name': 'Thane', 'population': '2.5', 'capacity': '450'},
          {'name': 'Nashik', 'population': '2.1', 'capacity': '380'},
          {'name': 'Aurangabad', 'population': '1.8', 'capacity': '320'},
          {'name': 'Solapur', 'population': '1.5', 'capacity': '280'},
          {'name': 'Kolhapur', 'population': '1.2', 'capacity': '250'},
          {'name': 'Amravati', 'population': '1.0', 'capacity': '220'},
        ];
      case 'Delhi':
        return [
          {'name': 'New Delhi', 'population': '8.5', 'capacity': '1,800'},
          {'name': 'North Delhi', 'population': '4.2', 'capacity': '900'},
          {'name': 'South Delhi', 'population': '3.8', 'capacity': '750'},
          {'name': 'East Delhi', 'population': '2.9', 'capacity': '600'},
          {'name': 'West Delhi', 'population': '2.6', 'capacity': '550'},
          {'name': 'Central Delhi', 'population': '2.1', 'capacity': '450'},
          {'name': 'Shahdara', 'population': '1.8', 'capacity': '380'},
          {'name': 'Dwarka', 'population': '1.5', 'capacity': '320'},
          {'name': 'Rohini', 'population': '1.2', 'capacity': '280'},
        ];
      case 'Karnataka':
        return [
          {'name': 'Bengaluru', 'population': '8.4', 'capacity': '1,600'},
          {'name': 'Mysuru', 'population': '3.2', 'capacity': '650'},
          {'name': 'Hubballi', 'population': '2.1', 'capacity': '450'},
          {'name': 'Mangaluru', 'population': '1.8', 'capacity': '380'},
          {'name': 'Belagavi', 'population': '1.5', 'capacity': '320'},
          {'name': 'Gulbarga', 'population': '1.3', 'capacity': '280'},
          {'name': 'Davangere', 'population': '1.1', 'capacity': '250'},
          {'name': 'Bellary', 'population': '1.0', 'capacity': '220'},
          {'name': 'Bijapur', 'population': '0.9', 'capacity': '200'},
        ];
      case 'Tamil Nadu':
        return [
          {'name': 'Chennai', 'population': '7.1', 'capacity': '1,400'},
          {'name': 'Coimbatore', 'population': '3.2', 'capacity': '650'},
          {'name': 'Madurai', 'population': '2.8', 'capacity': '580'},
          {'name': 'Salem', 'population': '1.9', 'capacity': '420'},
          {'name': 'Tiruchirappalli', 'population': '1.6', 'capacity': '350'},
          {'name': 'Vellore', 'population': '1.4', 'capacity': '300'},
          {'name': 'Erode', 'population': '1.2', 'capacity': '280'},
          {'name': 'Tiruppur', 'population': '1.1', 'capacity': '250'},
          {'name': 'Thoothukkudi', 'population': '1.0', 'capacity': '220'},
        ];
      case 'Gujarat':
        return [
          {'name': 'Ahmedabad', 'population': '7.2', 'capacity': '1,500'},
          {'name': 'Surat', 'population': '4.5', 'capacity': '950'},
          {'name': 'Vadodara', 'population': '2.1', 'capacity': '450'},
          {'name': 'Rajkot', 'population': '1.8', 'capacity': '380'},
          {'name': 'Bhavnagar', 'population': '1.2', 'capacity': '280'},
          {'name': 'Jamnagar', 'population': '1.0', 'capacity': '250'},
          {'name': 'Anand', 'population': '0.9', 'capacity': '220'},
          {'name': 'Bharuch', 'population': '0.8', 'capacity': '200'},
          {'name': 'Gandhinagar', 'population': '0.7', 'capacity': '180'},
        ];
      case 'Uttar Pradesh':
        return [
          {'name': 'Lucknow', 'population': '3.4', 'capacity': '750'},
          {'name': 'Kanpur', 'population': '3.0', 'capacity': '650'},
          {'name': 'Varanasi', 'population': '2.5', 'capacity': '550'},
          {'name': 'Agra', 'population': '2.1', 'capacity': '450'},
          {'name': 'Prayagraj', 'population': '1.8', 'capacity': '380'},
          {'name': 'Ghaziabad', 'population': '1.6', 'capacity': '350'},
          {'name': 'Noida', 'population': '1.4', 'capacity': '320'},
          {'name': 'Bareilly', 'population': '1.2', 'capacity': '280'},
          {'name': 'Aligarh', 'population': '1.0', 'capacity': '250'},
        ];
      case 'West Bengal':
        return [
          {'name': 'Kolkata', 'population': '4.5', 'capacity': '950'},
          {'name': 'Howrah', 'population': '1.8', 'capacity': '380'},
          {'name': 'Durgapur', 'population': '1.2', 'capacity': '280'},
          {'name': 'Asansol', 'population': '1.1', 'capacity': '250'},
          {'name': 'Siliguri', 'population': '1.0', 'capacity': '220'},
          {'name': 'Kharagpur', 'population': '0.9', 'capacity': '200'},
          {'name': 'Bardhaman', 'population': '0.8', 'capacity': '180'},
          {'name': 'Malda', 'population': '0.7', 'capacity': '160'},
          {'name': 'Cooch Behar', 'population': '0.6', 'capacity': '140'},
        ];
      case 'Telangana':
        return [
          {'name': 'Hyderabad', 'population': '6.8', 'capacity': '1,200'},
          {'name': 'Warangal', 'population': '1.8', 'capacity': '380'},
          {'name': 'Karimnagar', 'population': '1.2', 'capacity': '280'},
          {'name': 'Nizamabad', 'population': '1.0', 'capacity': '250'},
          {'name': 'Adilabad', 'population': '0.9', 'capacity': '220'},
          {'name': 'Khammam', 'population': '0.8', 'capacity': '200'},
          {'name': 'Nalgonda', 'population': '0.7', 'capacity': '180'},
          {'name': 'Medak', 'population': '0.6', 'capacity': '160'},
          {'name': 'Rangareddy', 'population': '0.5', 'capacity': '140'},
        ];
      case 'Andhra Pradesh':
        return [
          {'name': 'Visakhapatnam', 'population': '2.0', 'capacity': '450'},
          {'name': 'Vijayawada', 'population': '1.8', 'capacity': '380'},
          {'name': 'Guntur', 'population': '1.5', 'capacity': '320'},
          {'name': 'Nellore', 'population': '1.2', 'capacity': '280'},
          {'name': 'Kurnool', 'population': '1.0', 'capacity': '250'},
          {'name': 'Anantapur', 'population': '0.9', 'capacity': '220'},
          {'name': 'Kadapa', 'population': '0.8', 'capacity': '200'},
          {'name': 'Chittoor', 'population': '0.7', 'capacity': '180'},
          {'name': 'Prakasam', 'population': '0.6', 'capacity': '160'},
        ];
      case 'Kerala':
        return [
          {'name': 'Thiruvananthapuram', 'population': '1.8', 'capacity': '380'},
          {'name': 'Kochi', 'population': '1.6', 'capacity': '350'},
          {'name': 'Kozhikode', 'population': '1.4', 'capacity': '320'},
          {'name': 'Thrissur', 'population': '1.2', 'capacity': '280'},
          {'name': 'Kollam', 'population': '1.0', 'capacity': '250'},
          {'name': 'Alappuzha', 'population': '0.9', 'capacity': '220'},
          {'name': 'Palakkad', 'population': '0.8', 'capacity': '200'},
          {'name': 'Malappuram', 'population': '0.7', 'capacity': '180'},
          {'name': 'Kannur', 'population': '0.6', 'capacity': '160'},
        ];
      case 'Rajasthan':
        return [
          {'name': 'Jaipur', 'population': '3.1', 'capacity': '650'},
          {'name': 'Jodhpur', 'population': '1.8', 'capacity': '380'},
          {'name': 'Kota', 'population': '1.2', 'capacity': '280'},
          {'name': 'Bikaner', 'population': '1.0', 'capacity': '250'},
          {'name': 'Ajmer', 'population': '0.9', 'capacity': '220'},
          {'name': 'Udaipur', 'population': '0.8', 'capacity': '200'},
          {'name': 'Bhilwara', 'population': '0.7', 'capacity': '180'},
          {'name': 'Alwar', 'population': '0.6', 'capacity': '160'},
          {'name': 'Sri Ganganagar', 'population': '0.5', 'capacity': '140'},
        ];
      default:
        return [
          {'name': 'Capital City', 'population': '2.0', 'capacity': '500'},
          {'name': 'Major City 1', 'population': '1.5', 'capacity': '350'},
          {'name': 'Major City 2', 'population': '1.2', 'capacity': '280'},
          {'name': 'Major City 3', 'population': '1.0', 'capacity': '250'},
          {'name': 'Major City 4', 'population': '0.8', 'capacity': '200'},
          {'name': 'Major City 5', 'population': '0.7', 'capacity': '180'},
          {'name': 'Major City 6', 'population': '0.6', 'capacity': '160'},
          {'name': 'Major City 7', 'population': '0.5', 'capacity': '140'},
          {'name': 'Major City 8', 'population': '0.4', 'capacity': '120'},
        ];
    }
  }
}
