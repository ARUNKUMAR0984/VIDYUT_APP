import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';
import 'browse_brands_screen.dart';
import 'state_info_screen.dart';
import 'product_details_screen.dart';
import 'wishlist_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'user_profile_screen.dart';
import 'cart_screen.dart';

class D_SearchProductsScreen extends StatefulWidget {
  const D_SearchProductsScreen({super.key});

  @override
  State<D_SearchProductsScreen> createState() => _D_SearchProductsScreenState();
}

class _D_SearchProductsScreenState extends State<D_SearchProductsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _sidebarSearchController = TextEditingController();
  String _searchQuery = '';
  List<Map<String, dynamic>> _searchResults = [];
  bool _isSearching = false;
  
  // Filter and sort variables
  String _selectedCategory = 'All';
  String _selectedSortBy = 'Relevance';
  double _minPrice = 0;
  double _maxPrice = 10000;
  bool _inStockOnly = false;
  double _minRating = 0;
  bool _showFilters = false;

  @override
  void dispose() {
    _searchController.dispose();
    _sidebarSearchController.dispose();
    super.dispose();
  }

  // Product database
  final List<Map<String, dynamic>> _allProducts = [
    // Lights
    {
      'id': '1',
      'name': 'Philips LED Bulb 9W',
      'category': 'light',
      'price': '₹299',
      'image': 'assets/images/lights/philips_bulb_single_white_bg.jpeg',
      'description': 'Energy efficient LED bulb with 2 year warranty',
      'seller': 'Philips India',
      'rating': 4.5,
      'inStock': true,
    },
    {
      'id': '2',
      'name': 'Tube Light 60W',
      'category': 'light',
      'price': '₹450',
      'image': 'assets/images/lights/tube_lights_60w_single_white_bg.jpeg',
      'description': 'High quality fluorescent tube light',
      'seller': 'Bajaj Electricals',
      'rating': 4.2,
      'inStock': true,
    },
    {
      'id': '3',
      'name': 'Event Light 60W',
      'category': 'light',
      'price': '₹1,299',
      'image': 'assets/images/lights/event_lights_60w_single_white_bg.jpeg',
      'description': 'Professional event lighting solution',
      'seller': 'Havells',
      'rating': 4.7,
      'inStock': true,
    },
    {
      'id': '4',
      'name': 'Philips Bulb Variant',
      'category': 'light',
      'price': '₹2,499',
      'image': 'assets/images/lights/philips_bulb_single_white_bg.jpeg',
      'description': 'Premium LED bulb variant',
      'seller': 'Syska LED',
      'rating': 4.3,
      'inStock': true,
    },
    // Wires
    {
      'id': '5',
      'name': 'Copper Wire 2.5mm',
      'category': 'wire',
      'price': '₹120/meter',
      'image': 'assets/images/wires-and-cables/wires1.jpeg',
      'description': 'High grade copper wire for house wiring',
      'seller': 'Polycab Wires',
      'rating': 4.6,
      'inStock': true,
    },
    {
      'id': '6',
      'name': 'Armoured Cable 4 Core',
      'category': 'wire',
      'price': '₹89/meter',
      'image': 'assets/images/wires-and-cables/wires2.jpeg',
      'description': 'Underground armoured power cable',
      'seller': 'KEI Industries',
      'rating': 4.4,
      'inStock': true,
    },
    {
      'id': '7',
      'name': 'Flexible Wire 1.5mm',
      'category': 'wire',
      'price': '₹65/meter',
      'image': 'assets/images/wires-and-cables/wires3.jpeg',
      'description': 'Flexible copper wire for appliances',
      'seller': 'Finolex Cables',
      'rating': 4.5,
      'inStock': true,
    },
    {
      'id': '8',
      'name': 'Coaxial Cable RG6',
      'category': 'wire',
      'price': '₹45/meter',
      'image': 'assets/images/wires-and-cables/wires4.jpeg',
      'description': 'High quality coaxial cable for TV/Internet',
      'seller': 'V-Guard',
      'rating': 4.3,
      'inStock': true,
    },
    // Motors
    {
      'id': '9',
      'name': 'Electric Motor 1HP',
      'category': 'motor',
      'price': '₹8,999',
      'image': 'assets/images/motors/electric_motors_with_white_bg.jpeg',
      'description': 'High efficiency electric motor',
      'seller': 'Crompton Greaves',
      'rating': 4.8,
      'inStock': true,
    },
    {
      'id': '10',
      'name': 'Industrial Motor 2HP',
      'category': 'motor',
      'price': '₹1,899',
      'image': 'assets/images/motors/electric_motors_with_white_bg.jpeg',
      'description': 'Industrial grade motor',
      'seller': 'Orient Electric',
      'rating': 4.4,
      'inStock': true,
    },
    {
      'id': '11',
      'name': 'Heavy Duty Motor 5HP',
      'category': 'motor',
      'price': '₹15,999',
      'image': 'assets/images/motors/electric_motors_with_white_bg.jpeg',
      'description': 'Three phase heavy duty motor',
      'seller': 'ABB India',
      'rating': 4.9,
      'inStock': true,
    },
    {
      'id': '12',
      'name': 'Specialty Motor',
      'category': 'motor',
      'price': '₹2,299',
      'image': 'assets/images/motors/electric_motors_with_white_bg.jpeg',
      'description': 'Specialized electric motor',
      'seller': 'Symphony',
      'rating': 4.2,
      'inStock': true,
    },
    // Switches
    {
      'id': '13',
      'name': 'Electric Switch',
      'category': 'switch',
      'price': '₹150',
      'image': 'assets/images/switches/electric_switch_white_bg.jpeg',
      'description': 'Standard electric wall switch',
      'seller': 'Havells',
      'rating': 4.3,
      'inStock': true,
    },
    {
      'id': '14',
      'name': 'Industrial Switch',
      'category': 'switch',
      'price': '₹450',
      'image': 'assets/images/switches/industrial_switches_with_white_bg.jpeg',
      'description': 'Heavy duty industrial switch',
      'seller': 'Schneider Electric',
      'rating': 4.6,
      'inStock': true,
    },
    // Circuit Breakers
    {
      'id': '15',
      'name': 'MCB 32A',
      'category': 'circuit_breaker',
      'price': '₹299',
      'image': 'assets/images/circuit-breakers/electric_mcb_60w_single_white_bg.jpeg',
      'description': 'Miniature Circuit Breaker 32A',
      'seller': 'Siemens',
      'rating': 4.7,
      'inStock': true,
    },
    {
      'id': '16',
      'name': 'Circuit Breaker Panel',
      'category': 'circuit_breaker',
      'price': '₹1,299',
      'image': 'assets/images/circuit-breakers/circuit_breakers_single_white_bg.jpeg',
      'description': 'Complete circuit breaker panel',
      'seller': 'ABB India',
      'rating': 4.8,
      'inStock': true,
    },
    // Electrical Panels
    {
      'id': '17',
      'name': 'Distribution Panel 60A',
      'category': 'panel',
      'price': '₹2,999',
      'image': 'assets/images/panels/electric_panels_60w_single_white_bg.jpeg',
      'description': 'Main distribution panel for commercial use',
      'seller': 'Schneider Electric',
      'rating': 4.7,
      'inStock': true,
    },
    {
      'id': '18',
      'name': 'Sub Distribution Panel',
      'category': 'panel',
      'price': '₹1,899',
      'image': 'assets/images/panels/electric_panels_60w_single_white_bg (1).jpeg',
      'description': 'Sub distribution panel for residential use',
      'seller': 'Havells',
      'rating': 4.5,
      'inStock': true,
    },
    {
      'id': '19',
      'name': 'Industrial Control Panel',
      'category': 'panel',
      'price': '₹5,999',
      'image': 'assets/images/panels/electric_panels_60w_single_white_bg (2).jpeg',
      'description': 'Heavy duty industrial control panel',
      'seller': 'Siemens',
      'rating': 4.9,
      'inStock': true,
    },
    // Electrical Tools
    {
      'id': '20',
      'name': 'Electric Screwdriver Set',
      'category': 'tool',
      'price': '₹1,499',
      'image': 'assets/images/tools/screwdriver_single_white_bg.jpeg',
      'description': 'Professional electric screwdriver set',
      'seller': 'Bosch',
      'rating': 4.6,
      'inStock': true,
    },
    {
      'id': '21',
      'name': 'Multimeter Digital',
      'category': 'tool',
      'price': '₹899',
      'image': 'assets/images/tools/electric_tools_single_white_bg.jpeg',
      'description': 'Digital multimeter for electrical testing',
      'seller': 'Fluke',
      'rating': 4.8,
      'inStock': true,
    },
    {
      'id': '22',
      'name': 'Wire Stripper Tool',
      'category': 'tool',
      'price': '₹299',
      'image': 'assets/images/tools/electric_tools_single_white_bg (1).jpeg',
      'description': 'Professional wire stripping tool',
      'seller': 'Klein Tools',
      'rating': 4.4,
      'inStock': true,
    },
    {
      'id': '23',
      'name': 'Cable Tester Kit',
      'category': 'tool',
      'price': '₹599',
      'image': 'assets/images/tools/electric_tools_single_white_bg (2).jpeg',
      'description': 'Complete cable testing kit',
      'seller': 'Extech',
      'rating': 4.3,
      'inStock': true,
    },
    // Safety Equipment
    {
      'id': '24',
      'name': 'Safety Gloves Electrical',
      'category': 'safety',
      'price': '₹199',
      'image': 'assets/images/safety/safety_gloves_single_white_bg.jpeg',
      'description': 'High voltage electrical safety gloves',
      'seller': 'Stanley',
      'rating': 4.5,
      'inStock': true,
    },
    {
      'id': '25',
      'name': 'Fire Resistant Suit',
      'category': 'safety',
      'price': '₹2,999',
      'image': 'assets/images/safety/fireman_suit_safety_single_white_bg.jpeg',
      'description': 'Fire resistant safety suit for electrical work',
      'seller': '3M',
      'rating': 4.7,
      'inStock': true,
    },
    {
      'id': '26',
      'name': 'Safety Helmet Electrical',
      'category': 'safety',
      'price': '₹399',
      'image': 'assets/images/safety/safety_gloves_single_white_bg (1).jpeg',
      'description': 'Electrical safety helmet with insulation',
      'seller': 'Honeywell',
      'rating': 4.4,
      'inStock': true,
    },
    // Transformers
    {
      'id': '27',
      'name': 'Step Down Transformer 5KVA',
      'category': 'transformer',
      'price': '₹8,999',
      'image': 'assets/images/transformer/electric_transformers_should_be_with_white_bg.jpeg',
      'description': '5KVA step down transformer',
      'seller': 'Crompton Greaves',
      'rating': 4.8,
      'inStock': true,
    },
    {
      'id': '28',
      'name': 'Distribution Transformer',
      'category': 'transformer',
      'price': '₹15,999',
      'image': 'assets/images/transformer/electric_transformers_should_be_with_white_bg (1).jpeg',
      'description': 'Distribution transformer for commercial use',
      'seller': 'ABB India',
      'rating': 4.9,
      'inStock': true,
    },
    {
      'id': '29',
      'name': 'Isolation Transformer',
      'category': 'transformer',
      'price': '₹12,999',
      'image': 'assets/images/transformer/electric_transformers_should_be_with_white_bg (2).jpeg',
      'description': 'Isolation transformer for sensitive equipment',
      'seller': 'Siemens',
      'rating': 4.6,
      'inStock': true,
    },
    // Conduits
    {
      'id': '30',
      'name': 'PVC Conduit Pipe 20mm',
      'category': 'conduit',
      'price': '₹45/meter',
      'image': 'assets/images/conduits/electric_conduits_single_white_bg.jpeg',
      'description': 'PVC electrical conduit pipe',
      'seller': 'Finolex',
      'rating': 4.3,
      'inStock': true,
    },
    {
      'id': '31',
      'name': 'Metal Conduit 25mm',
      'category': 'conduit',
      'price': '₹89/meter',
      'image': 'assets/images/conduits/electric_conduits_single_white_bg (1).jpeg',
      'description': 'Galvanized metal conduit pipe',
      'seller': 'KEI Industries',
      'rating': 4.5,
      'inStock': true,
    },
    {
      'id': '32',
      'name': 'Flexible Conduit',
      'category': 'conduit',
      'price': '₹65/meter',
      'image': 'assets/images/conduits/electric_conduits_single_white_bg (2).jpeg',
      'description': 'Flexible electrical conduit',
      'seller': 'Polycab',
      'rating': 4.2,
      'inStock': true,
    },
    // Additional Lights
    {
      'id': '33',
      'name': 'Philips Bulb Premium',
      'category': 'light',
      'price': '₹399',
      'image': 'assets/images/lights/philips_bulb_single_white_bg (2).jpeg',
      'description': 'Premium LED bulb with extended warranty',
      'seller': 'Philips India',
      'rating': 4.7,
      'inStock': true,
    },
    {
      'id': '34',
      'name': 'Tube Light Professional',
      'category': 'light',
      'price': '₹550',
      'image': 'assets/images/lights/tube_lights_60w_single_white_bg (1).jpeg',
      'description': 'Professional grade tube light',
      'seller': 'Bajaj Electricals',
      'rating': 4.4,
      'inStock': true,
    },
    // Additional Wires
    {
      'id': '35',
      'name': 'Copper Wire 4mm',
      'category': 'wire',
      'price': '₹180/meter',
      'image': 'assets/images/wires-and-cables/wires5.jpeg',
      'description': 'Heavy duty 4mm copper wire',
      'seller': 'Polycab Wires',
      'rating': 4.6,
      'inStock': true,
    },
    {
      'id': '36',
      'name': 'Control Cable 6 Core',
      'category': 'wire',
      'price': '₹120/meter',
      'image': 'assets/images/wires-and-cables/wires6.jpeg',
      'description': '6 core control cable for automation',
      'seller': 'KEI Industries',
      'rating': 4.5,
      'inStock': true,
    },
  ];

  void _performSearch(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      _isSearching = true;
    });

    // Simulate search delay
    Future.delayed(const Duration(milliseconds: 500), () {
      if (_searchQuery.isEmpty) {
        setState(() {
          _searchResults = [];
          _isSearching = false;
        });
        return;
      }

      // Perform search with filters
      List<Map<String, dynamic>> results = _allProducts.where((product) {
        bool matchesSearch = product['name'].toLowerCase().contains(_searchQuery) ||
               product['category'].toLowerCase().contains(_searchQuery) ||
               product['description'].toLowerCase().contains(_searchQuery);
        
        bool matchesCategory = _selectedCategory == 'All' || product['category'] == _selectedCategory.toLowerCase();
        bool matchesStock = !_inStockOnly || product['inStock'] == true;
        bool matchesRating = product['rating'] >= _minRating;
        
        // Parse price for filtering
        String priceStr = product['price'].toString().replaceAll('₹', '').replaceAll(',', '').replaceAll('/meter', '');
        double price = double.tryParse(priceStr) ?? 0;
        bool matchesPrice = price >= _minPrice && price <= _maxPrice;
        
        return matchesSearch && matchesCategory && matchesStock && matchesRating && matchesPrice;
      }).toList();

      // Apply sorting
      _applySorting(results);

      setState(() {
        _searchResults = results;
        _isSearching = false;
      });
    });
  }

  void _applySorting(List<Map<String, dynamic>> results) {
    switch (_selectedSortBy) {
      case 'Price: Low to High':
        results.sort((a, b) {
          double priceA = double.tryParse(a['price'].toString().replaceAll('₹', '').replaceAll(',', '').replaceAll('/meter', '')) ?? 0;
          double priceB = double.tryParse(b['price'].toString().replaceAll('₹', '').replaceAll(',', '').replaceAll('/meter', '')) ?? 0;
          return priceA.compareTo(priceB);
        });
        break;
      case 'Price: High to Low':
        results.sort((a, b) {
          double priceA = double.tryParse(a['price'].toString().replaceAll('₹', '').replaceAll(',', '').replaceAll('/meter', '')) ?? 0;
          double priceB = double.tryParse(b['price'].toString().replaceAll('₹', '').replaceAll(',', '').replaceAll('/meter', '')) ?? 0;
          return priceB.compareTo(priceA);
        });
        break;
      case 'Rating: High to Low':
        results.sort((a, b) => b['rating'].compareTo(a['rating']));
        break;
      case 'Name: A to Z':
        results.sort((a, b) => a['name'].compareTo(b['name']));
        break;
      case 'Name: Z to A':
        results.sort((a, b) => b['name'].compareTo(a['name']));
        break;
      default: // Relevance
        // Keep original order for relevance
        break;
    }
  }

  void _applyFilters() {
    _performSearch(_searchQuery);
  }

  void _clearFilters() {
    setState(() {
      _selectedCategory = 'All';
      _selectedSortBy = 'Relevance';
      _minPrice = 0;
      _maxPrice = 10000;
      _inStockOnly = false;
      _minRating = 0;
    });
    _applyFilters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left Sidebar Navigation
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
                          color: Colors.blue[600],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'V',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Vidyut Nidhi',
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[800],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Sidebar Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _sidebarSearchController,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: GoogleFonts.inter(color: Colors.grey[500]),
                      prefixIcon: Icon(Icons.search, color: Colors.blue[800]),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.grid_view, color: Colors.grey[600]),
                        onPressed: () {},
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.blue[300]!),
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildNavItem(Icons.home, 'Home'),
                        _buildNavItem(Icons.search, 'Search Products', isActive: true),
                        _buildNavItem(Icons.branding_watermark, 'Browse Brands'),
                        _buildNavItem(Icons.shopping_bag, 'My Orders', badge: '3'),
                        _buildNavItem(Icons.favorite, 'Wishlist'),
                        _buildNavItem(Icons.store, 'Sell'),
                        _buildNavItem(Icons.message, 'Messages'),
                        _buildNavItem(Icons.location_on, 'State Info'),
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
          
          // Main Content Area
          Expanded(
            child: Column(
              children: [
                // Top Header
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
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
                            hintText: 'Search products... (try: light, wire, motor)',
                            hintStyle: GoogleFonts.inter(color: Colors.grey[500]),
                            prefixIcon: Icon(Icons.search, color: Colors.blue[800]),
                            suffixIcon: _searchController.text.isNotEmpty
                                ? IconButton(
                                    icon: Icon(Icons.clear, color: Colors.grey[600]),
                                    onPressed: () {
                                      _searchController.clear();
                                      _performSearch('');
                                    },
                                  )
                                : IconButton(
                                    icon: Icon(Icons.grid_view, color: Colors.grey[600]),
                                    onPressed: () {},
                                  ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.blue[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.blue[800]!, width: 2),
                            ),
                            filled: true,
                            fillColor: Colors.grey[50],
                          ),
                          onChanged: (value) {
                            _performSearch(value);
                          },
                          onSubmitted: (value) {
                            _performSearch(value);
                          },
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
                            Text('Deliver to: Set location', style: GoogleFonts.inter(color: Colors.grey[600])),
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
                        },
                        child: Text(
                          'Sign In',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue[800],
                          ),
                        ),
                      ),
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
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text(
                          'Sign Up',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      
                      const SizedBox(width: 20),
                      
                      // User Avatar with dropdown
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          switch (value) {
                            case 'profile':
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const UserProfileScreen()),
                              );
                              break;
                            case 'orders':
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const CartScreen()),
                              );
                              break;
                            case 'wishlist':
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const WishlistScreen()),
                              );
                              break;
                            case 'settings':
                              _showSettingsDialog();
                              break;
                            case 'logout':
                              _showLogoutDialog();
                              break;
                          }
                        },
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem<String>(
                            value: 'profile',
                            child: Row(
                              children: [
                                Icon(Icons.person, color: Colors.grey[600], size: 20),
                                const SizedBox(width: 12),
                                Text(
                                  'My Profile',
                                  style: GoogleFonts.inter(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem<String>(
                            value: 'orders',
                            child: Row(
                              children: [
                                Icon(Icons.shopping_bag, color: Colors.grey[600], size: 20),
                                const SizedBox(width: 12),
                                Text(
                                  'My Orders',
                                  style: GoogleFonts.inter(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem<String>(
                            value: 'wishlist',
                            child: Row(
                              children: [
                                Icon(Icons.favorite, color: Colors.grey[600], size: 20),
                                const SizedBox(width: 12),
                                Text(
                                  'Wishlist',
                                  style: GoogleFonts.inter(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          const PopupMenuDivider(),
                          PopupMenuItem<String>(
                            value: 'settings',
                            child: Row(
                              children: [
                                Icon(Icons.settings, color: Colors.grey[600], size: 20),
                                const SizedBox(width: 12),
                                Text(
                                  'Settings',
                                  style: GoogleFonts.inter(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem<String>(
                            value: 'logout',
                            child: Row(
                              children: [
                                Icon(Icons.logout, color: Colors.red[600], size: 20),
                                const SizedBox(width: 12),
                                Text(
                                  'Logout',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Colors.red[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.blue[800],
                          child: Text(
                            'JD',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Main Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Search Content
                        if (_searchQuery.isEmpty) ...[
                          // Empty State
                          const SizedBox(height: 100),
                          Icon(
                            Icons.search,
                            size: 80,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Search Products',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Enter a search term to find electrical products',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 40),
                          
                          // Search Suggestions
                          Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            alignment: WrapAlignment.center,
                            children: [
                              _buildSearchSuggestion('light'),
                              _buildSearchSuggestion('wire'),
                              _buildSearchSuggestion('motor'),
                              _buildSearchSuggestion('switch'),
                              _buildSearchSuggestion('circuit'),
                              _buildSearchSuggestion('panel'),
                              _buildSearchSuggestion('tool'),
                              _buildSearchSuggestion('safety'),
                              _buildSearchSuggestion('transformer'),
                              _buildSearchSuggestion('conduit'),
                            ],
                          ),
                        ] else ...[
                          // Search Results
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Search Results for "$_searchQuery"',
                                    style: GoogleFonts.inter(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[900],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${_searchResults.length} products found',
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      // Filter button
                                      OutlinedButton.icon(
                                        onPressed: () {
                                          setState(() {
                                            _showFilters = !_showFilters;
                                          });
                                        },
                                        icon: Icon(Icons.filter_list, color: Colors.blue[800]),
                                        label: Text(
                                          'Filters',
                                          style: GoogleFonts.inter(color: Colors.blue[800]),
                                        ),
                                        style: OutlinedButton.styleFrom(
                                          side: BorderSide(color: Colors.blue[800]!),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      // Sort dropdown
                                      DropdownButton<String>(
                                        value: _selectedSortBy,
                                        underline: Container(),
                                        style: GoogleFonts.inter(color: Colors.grey[700]),
                                        items: [
                                          'Relevance',
                                          'Price: Low to High',
                                          'Price: High to Low',
                                          'Rating: High to Low',
                                          'Name: A to Z',
                                          'Name: Z to A',
                                        ].map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value, style: GoogleFonts.inter()),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          if (newValue != null) {
                                            setState(() {
                                              _selectedSortBy = newValue;
                                            });
                                            _applyFilters();
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              
                              // Filter Panel
                              if (_showFilters)
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[50],
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.grey[300]!),
                                  ),
                                  child: _buildFilterPanel(),
                                ),
                              
                              const SizedBox(height: 30),
                              
                              // Loading indicator
                              if (_isSearching) ...[
                                const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                const SizedBox(height: 40),
                              ] else if (_searchResults.isEmpty && _searchQuery.isNotEmpty) ...[
                                // No results
                                Center(
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.search_off,
                                        size: 80,
                                        color: Colors.grey[400],
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        'No products found for "$_searchQuery"',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Try searching for: light, wire, motor, switch, cable',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[500],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 40),
                              ] else ...[
                                // Results Grid
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20,
                                    childAspectRatio: 0.75,
                                  ),
                                  itemCount: _searchResults.length,
                                  itemBuilder: (context, index) {
                                    return _buildProductCard(_searchResults[index]);
                                  },
                                ),
                              ],
                            ],
                          ),
                        ],
                      ],
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
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: ListTile(
        leading: Icon(
          icon,
          color: isActive ? Colors.blue[600] : Colors.grey[600],
        ),
        title: Text(
          title,
          style: GoogleFonts.inter(
            color: isActive ? Colors.blue[800] : Colors.grey[700],
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
        trailing: badge != null
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  badge,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : null,
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
          } else if (title == 'Wishlist') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WishlistScreen()),
            );
          }
        },
      ),
    );
  }
  
  Widget _buildSearchSuggestion(String suggestion) {
    return InkWell(
      onTap: () {
        setState(() {
          _searchQuery = suggestion;
          _searchController.text = suggestion;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.blue[200]!),
        ),
        child: Text(
          suggestion,
          style: TextStyle(
            color: Colors.blue[700],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
  
  Widget _buildFilters() {
    return Row(
      children: [
        const Text(
          'Filters: ',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 16),
        _buildFilterChip('Price: Low to High'),
        const SizedBox(width: 12),
        _buildFilterChip('Rating: 4+'),
        const SizedBox(width: 12),
        _buildFilterChip('Brand'),
        const SizedBox(width: 12),
        _buildFilterChip('Category'),
      ],
    );
  }
  
  Widget _buildFilterChip(String label) {
    return FilterChip(
      label: Text(label),
      selected: false,
      onSelected: (bool selected) {},
      backgroundColor: Colors.grey[100],
      selectedColor: Colors.blue[100],
      checkmarkColor: Colors.blue[600],
    );
  }
  
  Widget _buildSearchResultCard(int index) {
    // Sample search result data
    final List<Map<String, dynamic>> searchResults = [
      {
        'title': 'Smart WiFi Switch with Energy Monitoring',
        'rating': 4.8,
        'reviews': 342,
        'price': '₹2,499',
        'originalPrice': '₹3,299',
        'discount': '24% OFF',
        'image': 'assets/images/product-1.jpg',
        'brand': 'Crompton',
      },
      {
        'title': 'Premium MCB 32A Single Pole Circuit Breaker',
        'rating': 4.9,
        'reviews': 2340,
        'price': '₹899',
        'originalPrice': null,
        'discount': null,
        'image': 'assets/images/product-2.jpg',
        'brand': 'Schneider',
      },
      {
        'title': 'Industrial LED High Bay Light 150W',
        'rating': 4.6,
        'reviews': 128,
        'price': '₹8,999',
        'originalPrice': null,
        'discount': null,
        'image': 'assets/images/product-3.jpg',
        'brand': 'Philips',
      },
      {
        'title': 'LED Panel Light 40W Ultra Slim',
        'rating': 4.8,
        'reviews': 1890,
        'price': '₹2,199',
        'originalPrice': '₹2,799',
        'discount': '21% OFF',
        'image': 'assets/images/product-4.jpg',
        'brand': 'Havells',
      },
      {
        'title': 'Digital Energy Meter Single Phase',
        'rating': 4.7,
        'reviews': 567,
        'price': '₹1,899',
        'originalPrice': null,
        'discount': null,
        'image': 'assets/images/product-1.jpg',
        'brand': 'ABB',
      },
      {
        'title': 'Solar Panel Mounting Bracket Kit',
        'rating': 4.5,
        'reviews': 234,
        'price': '₹3,499',
        'originalPrice': '₹4,199',
        'discount': '17% OFF',
        'image': 'assets/images/product-2.jpg',
        'brand': 'Siemens',
      },
      {
        'title': 'Heavy Duty Extension Cord 15A',
        'rating': 4.6,
        'reviews': 892,
        'price': '₹1,299',
        'originalPrice': null,
        'discount': null,
        'image': 'assets/images/product-3.jpg',
        'brand': 'Anchor',
      },
      {
        'title': 'Smart Home Automation Hub',
        'rating': 4.9,
        'reviews': 156,
        'price': '₹5,999',
        'originalPrice': '₹7,499',
        'discount': '20% OFF',
        'image': 'assets/images/product-4.jpg',
        'brand': 'Legrand',
      },
    ];
    
    final product = searchResults[index];
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image with Badges
          Stack(
            children: [
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Image.asset(
                    product['image'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: Icon(
                          Icons.electrical_services,
                          size: 50,
                          color: Colors.grey[400],
                        ),
                      );
                    },
                  ),
                ),
              ),
              
              // Brand Badge
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue[600],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    product['brand'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              
              if (product['discount'] != null)
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red[600],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      product['discount'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          
          // Product Details
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Title
                Text(
                  product['title'],
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: 6),
                
                // Rating and Reviews
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 14,
                      color: Colors.amber[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${product['rating']}',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      ' (${product['reviews']})',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 6),
                
                // Price
                Row(
                  children: [
                    Text(
                      product['price'],
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const Text(' /Unit'),
                    if (product['originalPrice'] != null) ...[
                      const SizedBox(width: 8),
                      Text(
                        product['originalPrice'],
                        style: TextStyle(
                          fontSize: 13,
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ],
                ),
                
                const SizedBox(height: 10),
                
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[600],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          'Contact Supplier',
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 6),
                
                // Secondary Actions
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          'View Details',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          'Message',
                          style: TextStyle(fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.asset(
                product['image'],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  print('Error loading image: ${product['image']} - $error');
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _getProductIcon(product['category']),
                          size: 60,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Image not found',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          
          // Product Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    product['name'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 4),
                  
                  // Product Description
                  Text(
                    product['description'],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Price and Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product['price'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 14,
                            color: Colors.orange[400],
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${product['rating']}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Seller
                  Text(
                    'by ${product['seller']}',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey[500],
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsScreen(
                                  product: product,
                                  allProducts: _allProducts,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[600],
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: const Text(
                            'View Product',
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 6),
                  
                  // Contact and Message buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            _contactSeller(product);
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.green[600],
                            side: BorderSide(color: Colors.green[600]!),
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: const Text(
                            'Contact Seller',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            _messageSeller(product);
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.orange[600],
                            side: BorderSide(color: Colors.orange[600]!),
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: const Text(
                            'Message',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 6),
                  
                  // Wishlist Button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => _addToWishlist(product),
                      icon: const Icon(Icons.favorite_border, size: 12),
                      label: const Text(
                        'Add to Wishlist',
                        style: TextStyle(fontSize: 10),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red[600],
                        side: BorderSide(color: Colors.red[300]!),
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
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

  IconData _getProductIcon(String category) {
    switch (category.toLowerCase()) {
      case 'light':
        return Icons.lightbulb;
      case 'wire':
        return Icons.cable;
      case 'motor':
        return Icons.settings;
      case 'switch':
        return Icons.toggle_on;
      case 'circuit_breaker':
        return Icons.power;
      case 'panel':
        return Icons.dashboard;
      case 'tool':
        return Icons.build;
      case 'safety':
        return Icons.security;
      case 'transformer':
        return Icons.transform;
      case 'conduit':
        return Icons.timeline;
      default:
        return Icons.electrical_services;
    }
  }

  void _showProductDialog(Map<String, dynamic> product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            width: 500,
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product['name'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      product['image'],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                          ),
                          child: Icon(
                            _getProductIcon(product['category']),
                            size: 80,
                            color: Colors.grey[600],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                Text(
                  product['description'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product['price'],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange[400], size: 16),
                        const SizedBox(width: 4),
                        Text('${product['rating']} rating'),
                      ],
                    ),
                  ],
                ),
                
                const SizedBox(height: 8),
                
                Text(
                  'Seller: ${product['seller']}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _contactSeller(product);
                        },
                        icon: const Icon(Icons.phone, size: 16),
                        label: const Text('Contact Seller'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[600],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _messageSeller(product);
                        },
                        icon: const Icon(Icons.message, size: 16),
                        label: const Text('Send Message'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange[600],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _contactSeller(Map<String, dynamic> product) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Contacting ${product['seller']} for ${product['name']}'),
        backgroundColor: Colors.green[600],
        action: SnackBarAction(
          label: 'Call Now',
          textColor: Colors.white,
          onPressed: () {
            // Here you would implement actual calling functionality
          },
        ),
      ),
    );
  }

  void _messageSeller(Map<String, dynamic> product) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening chat with ${product['seller']}'),
        backgroundColor: Colors.orange[600],
        action: SnackBarAction(
          label: 'Open Chat',
          textColor: Colors.white,
          onPressed: () {
            // Here you would implement actual messaging functionality
          },
        ),
      ),
    );
  }

  void _addToWishlist(Map<String, dynamic> product) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product['name']} added to wishlist'),
        backgroundColor: Colors.red[600],
        action: SnackBarAction(
          label: 'View Wishlist',
          textColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const WishlistScreen()),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFilterPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Filters',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[900],
              ),
            ),
            TextButton(
              onPressed: _clearFilters,
              child: Text(
                'Clear All',
                style: GoogleFonts.inter(
                  color: Colors.blue[800],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Category Filter
        Text(
          'Category',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: ['All', 'Light', 'Wire', 'Motor', 'Switch', 'Circuit', 'Panel', 'Tool', 'Safety', 'Transformer', 'Conduit']
              .map((category) => FilterChip(
                    label: Text(category, style: GoogleFonts.inter()),
                    selected: _selectedCategory == category,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = category;
                      });
                      _applyFilters();
                    },
                    selectedColor: Colors.blue[100],
                    checkmarkColor: Colors.blue[800],
                  ))
              .toList(),
        ),
        
        const SizedBox(height: 16),
        
        // Price Range
        Text(
          'Price Range',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Min Price',
                  labelStyle: GoogleFonts.inter(color: Colors.grey[600]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blue[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blue[800]!, width: 2),
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _minPrice = double.tryParse(value) ?? 0;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Max Price',
                  labelStyle: GoogleFonts.inter(color: Colors.grey[600]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blue[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blue[800]!, width: 2),
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _maxPrice = double.tryParse(value) ?? 10000;
                },
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Rating Filter
        Text(
          'Minimum Rating',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _minRating = index + 1.0;
                });
                _applyFilters();
              },
              child: Icon(
                index < _minRating ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 24,
              ),
            );
          }),
        ),
        
        const SizedBox(height: 16),
        
        // Stock Filter
        Row(
          children: [
            Checkbox(
              value: _inStockOnly,
              onChanged: (value) {
                setState(() {
                  _inStockOnly = value ?? false;
                });
                _applyFilters();
              },
              activeColor: Colors.blue[800],
            ),
            Text(
              'In Stock Only',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Apply Filters Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _applyFilters,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[800],
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: Text(
              'Apply Filters',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Settings',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.notifications, color: Colors.blue[800]),
                title: Text(
                  'Notifications',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  'Manage your notification preferences',
                  style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[600]),
                ),
                trailing: Switch(
                  value: true,
                  onChanged: (value) {},
                  activeColor: Colors.blue[800],
                ),
              ),
              ListTile(
                leading: Icon(Icons.privacy_tip, color: Colors.blue[800]),
                title: Text(
                  'Privacy',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  'Control your privacy settings',
                  style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[600]),
                ),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Privacy settings coming soon!', style: GoogleFonts.inter()),
                      backgroundColor: Colors.blue[800],
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.help, color: Colors.blue[800]),
                title: Text(
                  'Help & Support',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  'Get help and contact support',
                  style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[600]),
                ),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Help center coming soon!', style: GoogleFonts.inter()),
                      backgroundColor: Colors.blue[800],
                    ),
                  );
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Close',
                style: GoogleFonts.inter(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Logout',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.bold,
              color: Colors.grey[900],
            ),
          ),
          content: Text(
            'Are you sure you want to logout? You will need to sign in again to access your account.',
            style: GoogleFonts.inter(color: Colors.grey[700]),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Logged out successfully!', style: GoogleFonts.inter()),
                    backgroundColor: Colors.green[600],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[600],
                foregroundColor: Colors.white,
              ),
              child: Text(
                'Logout',
                style: GoogleFonts.inter(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }
}
