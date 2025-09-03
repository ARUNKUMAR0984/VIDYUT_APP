import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'cart_screen.dart';
import 'wishlist_screen.dart';
import 'product_details_screen.dart';
import 'orders_screen.dart';
import 'seller_dashboard_screen.dart';
import 'b2b_leads_screen.dart';
import 'state_info_screen.dart';

class D_SearchProductsScreen extends StatefulWidget {
  final String? selectedCategory;
  
  const D_SearchProductsScreen({super.key, this.selectedCategory});

  @override
  State<D_SearchProductsScreen> createState() => _D_SearchProductsScreenState();
}

class _D_SearchProductsScreenState extends State<D_SearchProductsScreen> {
  final TextEditingController _searchController = TextEditingController();
  late String _selectedCategory;
  String _selectedSortBy = 'Best match';
  bool _isGridView = true;
  bool _showFilters = false;
  bool _isSidebarVisible = true;

  // Advanced filter state
  RangeValues _priceRange = const RangeValues(0, 20000);
  String _sellerType = 'All'; // All, Free, Plus, Pro
  String _selectedState = 'All';
  double _minRating = 0; // 0 to 5
  bool _showMaterials = false; // false = Products, true = Materials

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.selectedCategory ?? 'All Categories';
  }

  List<Map<String, dynamic>> get filteredProducts {
    // Base list
    List<Map<String, dynamic>> results = List<Map<String, dynamic>>.from(products);

    // Global search: product name, brand/seller, location/state
    final query = _searchController.text.trim().toLowerCase();
    if (query.isNotEmpty) {
      results = results.where((p) {
        final name = (p['name'] as String).toLowerCase();
        final seller = (p['seller'] as String).toLowerCase();
        final state = (p['state'] as String).toLowerCase();
        return name.contains(query) || seller.contains(query) || state.contains(query);
      }).toList();
    }

    // Category
    if (_selectedCategory != 'All Categories') {
      results = results.where((p) => p['category'] == _selectedCategory).toList();
    }

    // Type toggle (Products vs Materials)
    results = results.where((p) => (_showMaterials ? 'Material' : 'Product') == p['type']).toList();

    // Price filter (uses numeric priceValue field)
    results = results.where((p) {
      final price = (p['priceValue'] as num).toDouble();
      return price >= _priceRange.start && price <= _priceRange.end;
    }).toList();

    // Seller type
    if (_sellerType != 'All') {
      results = results.where((p) => p['sellerType'] == _sellerType).toList();
    }

    // State
    if (_selectedState != 'All') {
      results = results.where((p) => p['state'] == _selectedState).toList();
    }

    // Rating
    results = results.where((p) => (p['rating'] as num).toDouble() >= _minRating).toList();

    // Sorting
    switch (_selectedSortBy) {
      case 'Lowest price':
        results.sort((a, b) => (a['priceValue'] as num).compareTo(b['priceValue'] as num));
        break;
      case 'Highest price':
        results.sort((a, b) => (b['priceValue'] as num).compareTo(a['priceValue'] as num));
        break;
      case 'Verified sellers first':
        const order = {'Pro': 3, 'Plus': 2, 'Free': 1};
        results.sort((a, b) => (order[b['sellerType']]!).compareTo(order[a['sellerType']]!));
        break;
      case 'Best match':
      default:
        // Keep default order; could be enhanced with relevance scoring
        break;
    }

    return results;
  }

  // Sample products data
  final List<Map<String, dynamic>> products = [
    // Wires & Cables
    {
      'id': '1',
      'name': 'Copper Wire 2.5 sq.mm',
      'price': '₹2,500',
      'priceValue': 2500,
      'originalPrice': '₹3,200',
      'discount': '22%',
      'image': 'assets/images/wires-and-cables/wires1.jpeg',
      'seller': 'ElectroMax Industries',
      'rating': 4.0,
      'reviews': 128,
      'category': 'Wires & Cables',
      'sellerType': 'Pro',
      'state': 'Maharashtra',
      'type': 'Product',
      'stock': 50,
      'description': 'High-quality copper wire for electrical installations',
    },
    {
      'id': '2',
      'name': 'PVC Cable 4 sq.mm',
      'price': '₹3,800',
      'priceValue': 3800,
      'originalPrice': '₹4,500',
      'discount': '16%',
      'image': 'assets/images/wires-and-cables/wires2.jpeg',
      'seller': 'CableTech Solutions',
      'rating': 4.2,
      'reviews': 95,
      'category': 'Wires & Cables',
      'sellerType': 'Plus',
      'state': 'Gujarat',
      'type': 'Material',
      'stock': 30,
      'description': 'Flexible PVC insulated cable for indoor wiring',
    },
    // Switches
    {
      'id': '3',
      'name': 'MCB 32A Single Pole',
      'price': '₹180',
      'priceValue': 180,
      'originalPrice': '₹250',
      'discount': '28%',
      'image': 'assets/images/circuit-breakers/electric_mcb_60w_single_white_bg.jpeg',
      'seller': 'CircuitPro Ltd',
      'rating': 4.0,
      'reviews': 156,
      'category': 'Switches',
      'sellerType': 'Free',
      'state': 'Karnataka',
      'type': 'Product',
      'stock': 75,
      'description': 'Reliable circuit breaker for electrical protection',
    },
    {
      'id': '4',
      'name': 'Toggle Switch 16A',
      'price': '₹120',
      'priceValue': 120,
      'originalPrice': '₹150',
      'discount': '20%',
      'image': 'assets/images/switches/electric_switch_white_bg.jpeg',
      'seller': 'SwitchMaster',
      'rating': 4.3,
      'reviews': 89,
      'category': 'Switches',
      'sellerType': 'Plus',
      'state': 'Tamil Nadu',
      'type': 'Material',
      'stock': 120,
      'description': 'High-quality toggle switch for residential use',
    },
    // Lights
    {
      'id': '5',
      'name': 'LED Panel Light 18W',
      'price': '₹450',
      'priceValue': 450,
      'originalPrice': '₹600',
      'discount': '25%',
      'image': 'assets/images/lights/tube_lights_60w_single_white_bg.jpeg',
      'seller': 'LightTech Solutions',
      'rating': 4.0,
      'reviews': 89,
      'category': 'Lights',
      'sellerType': 'Pro',
      'state': 'Delhi',
      'type': 'Product',
      'stock': 200,
      'description': 'Energy-efficient LED panel light for commercial use',
    },
    {
      'id': '6',
      'name': 'LED Bulb 9W',
      'price': '₹299',
      'priceValue': 299,
      'originalPrice': '₹399',
      'discount': '25%',
      'image': 'assets/images/lights/philips_bulb_single_white_bg.jpeg',
      'seller': 'Philips Lighting',
      'rating': 4.5,
      'reviews': 234,
      'category': 'Lights',
      'sellerType': 'Pro',
      'state': 'Maharashtra',
      'type': 'Product',
      'stock': 150,
      'description': 'Energy-saving LED bulb with warm white light',
    },
    // Motors
    {
      'id': '7',
      'name': 'Industrial Motor 5HP',
      'price': '₹15,000',
      'priceValue': 15000,
      'originalPrice': '₹18,500',
      'discount': '19%',
      'image': 'assets/images/motors/electric_motors_with_white_bg.jpeg',
      'seller': 'MotorWorks India',
      'rating': 4.5,
      'reviews': 67,
      'category': 'Motors',
      'sellerType': 'Pro',
      'state': 'Gujarat',
      'type': 'Product',
      'stock': 12,
      'description': 'Heavy-duty industrial motor for commercial applications',
    },
    {
      'id': '8',
      'name': 'Ceiling Fan Motor',
      'price': '₹1,200',
      'priceValue': 1200,
      'originalPrice': '₹1,500',
      'discount': '20%',
      'image': 'assets/images/motors/electric_motors_with_white_bg (1).jpeg',
      'seller': 'FanTech Industries',
      'rating': 4.2,
      'reviews': 156,
      'category': 'Motors',
      'sellerType': 'Free',
      'state': 'Punjab',
      'type': 'Material',
      'stock': 45,
      'description': 'High-efficiency ceiling fan motor',
    },
    // Panels
    {
      'id': '9',
      'name': 'Distribution Panel 100A',
      'price': '₹8,500',
      'priceValue': 8500,
      'originalPrice': '₹10,000',
      'discount': '15%',
      'image': 'assets/images/circuit-breakers/circuit_breakers_single_white_bg.jpeg',
      'seller': 'Panel Systems Ltd',
      'rating': 4.8,
      'reviews': 78,
      'category': 'Panels',
      'sellerType': 'Plus',
      'state': 'Rajasthan',
      'type': 'Product',
      'stock': 8,
      'description': 'Industrial distribution panel with advanced protection',
    },
    {
      'id': '10',
      'name': 'Control Panel 50A',
      'price': '₹4,200',
      'priceValue': 4200,
      'originalPrice': '₹5,000',
      'discount': '16%',
      'image': 'assets/images/circuit-breakers/circuit_breakers_single_white_bg (2).jpeg',
      'seller': 'ControlTech',
      'rating': 4.4,
      'reviews': 92,
      'category': 'Panels',
      'sellerType': 'Free',
      'state': 'Uttar Pradesh',
      'type': 'Material',
      'stock': 15,
      'description': 'Compact control panel for automation systems',
    },
    // Tools
    {
      'id': '11',
      'name': 'Digital Multimeter',
      'price': '₹1,200',
      'priceValue': 1200,
      'originalPrice': '₹1,800',
      'discount': '33%',
      'image': 'assets/images/tools/multimeter.jpeg',
      'seller': 'ToolMaster Pro',
      'rating': 4.3,
      'reviews': 189,
      'category': 'Tools',
      'sellerType': 'Pro',
      'state': 'Delhi',
      'type': 'Product',
      'stock': 45,
      'description': 'Professional digital multimeter for electrical testing',
    },
    {
      'id': '12',
      'name': 'Wire Stripper Set',
      'price': '₹450',
      'priceValue': 450,
      'originalPrice': '₹600',
      'discount': '25%',
      'image': 'assets/images/tools/wire_stripper.jpeg',
      'seller': 'ToolCraft',
      'rating': 4.1,
      'reviews': 134,
      'category': 'Tools',
      'sellerType': 'Plus',
      'state': 'Maharashtra',
      'type': 'Material',
      'stock': 80,
      'description': 'Professional wire stripping tool set',
    },
    // Additional products
    {
      'id': '13',
      'name': 'Industrial Switchgear Set',
      'price': '₹3,200',
      'priceValue': 3200,
      'originalPrice': '₹3,800',
      'discount': '16%',
      'image': 'assets/images/switches/industrial_switches_with_white_bg.jpeg',
      'seller': 'SwitchMaster',
      'rating': 4.2,
      'reviews': 72,
      'category': 'Switches',
      'sellerType': 'Pro',
      'state': 'Gujarat',
      'type': 'Product',
      'stock': 60,
      'description': 'Comprehensive switchgear kit for industrial panels',
    },
    {
      'id': '14',
      'name': 'Aluminium Cable 10 sq.mm',
      'price': '₹5,900',
      'priceValue': 5900,
      'originalPrice': '₹6,500',
      'discount': '9%',
      'image': 'assets/images/wires-and-cables/wires4.jpeg',
      'seller': 'CableTech Solutions',
      'rating': 4.0,
      'reviews': 51,
      'category': 'Wires & Cables',
      'sellerType': 'Free',
      'state': 'Tamil Nadu',
      'type': 'Material',
      'stock': 25,
      'description': 'Durable aluminium cable for commercial installations',
    },
    {
      'id': '15',
      'name': 'Event Light 60W Pack of 6',
      'price': '₹1,950',
      'priceValue': 1950,
      'originalPrice': '₹2,220',
      'discount': '12%',
      'image': 'assets/images/lights/event_lights_60w_single_white_bg.jpeg',
      'seller': 'LightTech Solutions',
      'rating': 4.3,
      'reviews': 142,
      'category': 'Lights',
      'sellerType': 'Plus',
      'state': 'Delhi',
      'type': 'Product',
      'stock': 110,
      'description': 'Pack of 6 decorative event lights for venues',
    },
    {
      'id': '16',
      'name': 'Three-Phase Motor 7.5HP',
      'price': '₹26,500',
      'priceValue': 26500,
      'originalPrice': '₹29,000',
      'discount': '9%',
      'image': 'assets/images/motors/electric_motors_with_white_bg (2).jpeg',
      'seller': 'MotorWorks India',
      'rating': 4.6,
      'reviews': 38,
      'category': 'Motors',
      'sellerType': 'Pro',
      'state': 'Maharashtra',
      'type': 'Product',
      'stock': 9,
      'description': 'High-efficiency industrial three-phase motor',
    },
    {
      'id': '17',
      'name': 'Safety Gloves (Electrical)',
      'price': '₹399',
      'priceValue': 399,
      'originalPrice': '₹480',
      'discount': '17%',
      'image': 'assets/images/safety/safety_gloves.jpeg',
      'seller': 'SafetyFirst Ltd',
      'rating': 4.2,
      'reviews': 210,
      'category': 'Tools',
      'sellerType': 'Free',
      'state': 'Rajasthan',
      'type': 'Product',
      'stock': 200,
      'description': 'Insulated gloves for safe electrical work',
    },

  ];

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
                        _buildNavItem(Icons.search, 'Search Products', isActive: true),
                        _buildNavItem(Icons.business, 'Browse Brands'),
                        _buildNavItem(Icons.shopping_bag, 'My Orders', badge: '3'),
                        _buildNavItem(Icons.store, 'Sell'),
                        _buildNavItem(Icons.message, 'Messages'),
                        _buildNavItem(Icons.location_on, 'State Info'),
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
                // Top Navigation Bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
                            child: const Center(
                              child: Icon(
                                Icons.flash_on,
                                color: Colors.white,
                                size: 18,
                              ),
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
                      
                      // Navigation Links
                      Row(
                          children: [
                          _buildNavLink('Home', false),
                          _buildNavLink('Products', true),
                          _buildNavLink('Suppliers', false),
                          _buildNavLink('Buy Leads', false),
                          _buildNavLink('Sell', false),
                        ],
                      ),
                      
                      const Spacer(),
                      
                      // Right Side Actions
                      Row(
                        children: [
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
                          
                          // Cart
                      IconButton(
                            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.grey),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const CartScreen()),
                              );
                            },
                          ),
                          
                          const SizedBox(width: 16),
                          
                          // Sign In
                          OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
                        },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.blue[800],
                              side: BorderSide(color: Colors.blue[800]!),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                        child: Text(
                          'Sign In',
                              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                          ),
                        ),
                          
                          const SizedBox(width: 12),
                          
                          // Register
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
                              'Register',
                              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                                ),
                              ],
                            ),
                          ),
                
                // Search and Filter Section
                Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                              children: [
                      // Search Bar
                      Row(
                              children: [
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Search by product, brand, or location...',
                                hintStyle: GoogleFonts.inter(color: Colors.grey[500]),
                                prefixIcon: const Icon(Icons.search, color: Colors.grey),
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
                          
                          const SizedBox(width: 16),
                          
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[800],
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          child: Text(
                              'Search',
                              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Filter and Sort Options
                      Row(
                      children: [
                          // Category Dropdown
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButton<String>(
                              value: _selectedCategory,
                              underline: const SizedBox(),
                              items: [
                                'All Categories',
                                'Wires & Cables',
                                'Circuit Breakers',
                                'Lights',
                                'Motors',
                                'Tools',
                                'Safety Equipment',
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: GoogleFonts.inter(fontSize: 14),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedCategory = newValue!;
                                });
                              },
                            ),
                          ),
                          
                          const SizedBox(width: 16),
                          
                          // Sort Dropdown
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: DropdownButton<String>(
                              value: _selectedSortBy,
                              underline: const SizedBox(),
                              items: [
                                'Best match',
                                'Lowest price',
                                'Highest price',
                                'Verified sellers first',
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: GoogleFonts.inter(fontSize: 14),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedSortBy = newValue!;
                                });
                              },
                            ),
                          ),
                          
                          const Spacer(),
                          
                          // Toggle Products vs Materials
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Row(
                            children: [
                                ChoiceChip(
                                  label: Text('Products', style: GoogleFonts.inter()),
                                  selected: !_showMaterials,
                                  onSelected: (v) => setState(() => _showMaterials = !v),
                                ),
                                const SizedBox(width: 8),
                                ChoiceChip(
                                  label: Text('Materials Used', style: GoogleFonts.inter()),
                                  selected: _showMaterials,
                                  onSelected: (v) => setState(() => _showMaterials = v),
                                ),
                              ],
                            ),
                          ),

                                      const SizedBox(width: 16),

                          // Filters Button
                                      OutlinedButton.icon(
                                        onPressed: () {
                                          setState(() {
                                            _showFilters = !_showFilters;
                                          });
                                        },
                            icon: const Icon(Icons.filter_list),
                            label: const Text('Filters'),
                                        style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.grey[700],
                              side: BorderSide(color: Colors.grey[400]!),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          
                          const SizedBox(width: 16),
                          
                          // View Toggle
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                            setState(() {
                                    _isGridView = true;
                                  });
                                },
                                icon: Icon(
                                  Icons.grid_view,
                                  color: _isGridView ? Colors.blue[800] : Colors.grey,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isGridView = false;
                                  });
                                },
                                icon: Icon(
                                  Icons.view_list,
                                  color: !_isGridView ? Colors.blue[800] : Colors.grey,
                                ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                    ],
                  ),
                ),
                              
                // Filters Panel (expand/collapse)
                              if (_showFilters)
                                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 4)),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Price range (₹)', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: RangeSlider(
                                values: _priceRange,
                                min: 0,
                                max: 20000,
                                divisions: 20,
                                labels: RangeLabels('₹${_priceRange.start.round()}', '₹${_priceRange.end.round()}'),
                                onChanged: (v) => setState(() => _priceRange = v),
                              ),
                            ),
                            SizedBox(
                              width: 120,
                              child: Text('₹${_priceRange.start.round()} - ₹${_priceRange.end.round()}', style: GoogleFonts.inter()),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        Row(
                          children: [
                            Text('Seller type:', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                            const SizedBox(width: 12),
                            DropdownButton<String>(
                              value: _sellerType,
                              items: const [
                                DropdownMenuItem(value: 'All', child: Text('All')),
                                DropdownMenuItem(value: 'Free', child: Text('Free')),
                                DropdownMenuItem(value: 'Plus', child: Text('Plus')),
                                DropdownMenuItem(value: 'Pro', child: Text('Pro')),
                              ],
                              onChanged: (v) => setState(() => _sellerType = v!),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        Row(
                                    children: [
                            Text('State:', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                            const SizedBox(width: 12),
                            DropdownButton<String>(
                              value: _selectedState,
                              items: const [
                                DropdownMenuItem(value: 'All', child: Text('All')),
                                DropdownMenuItem(value: 'Maharashtra', child: Text('Maharashtra')),
                                DropdownMenuItem(value: 'Gujarat', child: Text('Gujarat')),
                                DropdownMenuItem(value: 'Karnataka', child: Text('Karnataka')),
                                DropdownMenuItem(value: 'Tamil Nadu', child: Text('Tamil Nadu')),
                                DropdownMenuItem(value: 'Delhi', child: Text('Delhi')),
                                DropdownMenuItem(value: 'Punjab', child: Text('Punjab')),
                                DropdownMenuItem(value: 'Rajasthan', child: Text('Rajasthan')),
                                DropdownMenuItem(value: 'Uttar Pradesh', child: Text('Uttar Pradesh')),
                              ],
                              onChanged: (v) => setState(() => _selectedState = v!),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        Row(
                          children: [
                            Text('Min rating:', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Slider(
                                value: _minRating,
                                min: 0,
                                max: 5,
                                divisions: 5,
                                label: _minRating.toStringAsFixed(0),
                                onChanged: (v) => setState(() => _minRating = v),
                              ),
                            ),
                            SizedBox(width: 40, child: Text(_minRating.toStringAsFixed(1), style: GoogleFonts.inter())),
                          ],
                                      ),
                                    ],
                                  ),
                                ),

                // Results Summary
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${filteredProducts.length} Results Found',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                      Text(
                        'Showing 1-${filteredProducts.length} of ${filteredProducts.length}',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Products Grid
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: _isGridView ? _buildProductsGrid() : _buildProductsList(),
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
            // stay on this page
          } else if (title == 'My Orders') {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const OrdersScreen()));
          } else if (title == 'Wishlist') {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const WishlistScreen()));
          } else if (title == 'Shopping Cart') {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen()));
          } else if (title == 'Sell') {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SellerDashboardScreen()));
          } else if (title == 'B2B Leads') {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const B2BLeadsScreen()));
          } else if (title == 'State Info') {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const D_StateInfoScreen()));
          } else if (title == 'Settings') {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Settings coming soon', style: GoogleFonts.inter())));
          } else if (title == 'Help') {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Help center coming soon', style: GoogleFonts.inter())));
          }
        },
      ),
    );
  }
  
  Widget _buildNavLink(String title, bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextButton(
        onPressed: () {
          if (title == 'Home') {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const D_HomeScreen()),
              (route) => false,
            );
          } else if (title == 'Products') {
            // already here
          } else if (title == 'Suppliers') {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const B2BLeadsScreen()));
          } else if (title == 'Buy Leads') {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const B2BLeadsScreen()));
          } else if (title == 'Sell') {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SellerDashboardScreen()));
          }
        },
        child: Text(
          title,
          style: GoogleFonts.inter(
            color: isActive ? Colors.blue[800] : Colors.grey[700],
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
  
  Widget _buildProductsGrid() {
    final width = MediaQuery.of(context).size.width;
    final crossAxis = width < 700
        ? 2
        : width < 1100
            ? 3
            : 4;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxis,
        childAspectRatio: 0.8,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        final product = filteredProducts[index];
        return _buildProductCard(product);
      },
    );
  }

  Widget _buildProductsList() {
    return ListView.builder(
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        final product = filteredProducts[index];
        return _buildProductListItem(product);
      },
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(
                  product: product,
                  allProducts: products,
                ),
              ),
            );
          },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
              // Product Image
              Expanded(
                child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  color: Colors.grey[100],
                  ),
                  child: Stack(
                    children: [
                      // Product image
                      Positioned.fill(
                child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    product['image'],
                    fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Center(
                              child: Icon(Icons.image, size: 60, color: Colors.grey[400]),
                            ),
                  ),
                ),
              ),
              
                      // Discount Badge
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                            color: Colors.green[600],
                            borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                            product['discount'],
                            style: GoogleFonts.inter(
                      color: Colors.white,
                              fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              
                      // Wishlist Button
                Positioned(
                  top: 12,
                  right: 12,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_border,
                            color: Colors.grey,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Product Info
          Padding(
                padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                      product['name'],
                      style: GoogleFonts.inter(
                        fontSize: 14,
                    fontWeight: FontWeight.w600,
                        color: Colors.grey[900],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                    const SizedBox(height: 4),
                    
                    Text(
                      'by ${product['seller']}',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Rating
                Row(
                  children: [
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < product['rating'].floor() ? Icons.star : Icons.star_border,
                              color: Colors.amber,
                      size: 14,
                            );
                          }),
                    ),
                    const SizedBox(width: 4),
                    Text(
                          '(${product['reviews']})',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                
                    const SizedBox(height: 8),
                
                // Price
                    Text(
                      product['price'],
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                  ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildProductListItem(Map<String, dynamic> product) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsScreen(
                                  product: product,
                  allProducts: products,
                                ),
                              ),
                            );
                          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
                    children: [
                // Product Image
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    children: [
                      // Product image
                      Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      product['image'],
                      fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Center(
                              child: Icon(Icons.image, size: 40, color: Colors.grey[400]),
                            ),
                    ),
                  ),
                ),
                
                      // Discount Badge
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.green[600],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            product['discount'],
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 10,
                        fontWeight: FontWeight.bold,
                            ),
                          ),
                      ),
                    ),
                  ],
                ),
                ),
                
                const SizedBox(width: 16),
                
                // Product Info
                Expanded(
                  child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                        product['name'],
              style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                color: Colors.grey[900],
              ),
                      ),
                      
                      const SizedBox(height: 4),
                      
        Text(
                        'by ${product['seller']}',
          style: GoogleFonts.inter(
            fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      
        const SizedBox(height: 8),
                      
                      // Rating
        Row(
          children: [
        Row(
          children: List.generate(5, (index) {
                              return Icon(
                                index < product['rating'].floor() ? Icons.star : Icons.star_border,
                color: Colors.amber,
                                size: 16,
            );
          }),
        ),
                          const SizedBox(width: 8),
            Text(
                            '(${product['reviews']})',
              style: GoogleFonts.inter(
                fontSize: 14,
                              color: Colors.grey[600],
              ),
            ),
          ],
        ),
        
                      const SizedBox(height: 8),
                      
                      Text(
                        product['description'],
              style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                
                // Price and Actions
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      product['price'],
            style: GoogleFonts.inter(
                        fontSize: 18,
              fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[800],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Text(
                        'View Details',
                        style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
