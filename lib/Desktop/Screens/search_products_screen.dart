import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Components/responsive_helper.dart';
import '../Components/unified_navigation.dart';
import 'home_screen.dart';
import 'cart_screen.dart';
import 'wishlist_screen.dart';
import 'product_details_screen.dart';
import 'orders_screen.dart';
import 'seller_dashboard_screen.dart';
import 'state_info_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/link.dart';
import 'package:ionicons/ionicons.dart';

class D_SearchProductsScreen extends StatefulWidget {
  final String? selectedCategory;
  final String? selectedBrand;
  
  const D_SearchProductsScreen({super.key, this.selectedCategory, this.selectedBrand});

  @override
  State<D_SearchProductsScreen> createState() => _D_SearchProductsScreenState();
}

class _D_SearchProductsScreenState extends State<D_SearchProductsScreen> {
  final TextEditingController _searchController = TextEditingController();
  late String _selectedCategory;
  late String _selectedBrand;
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
    _selectedBrand = widget.selectedBrand ?? 'All Brands';
  }

  final Map<String, String> _sellerPhoneMap = const {
    'ElectroMart': '+919999000001',
    'Power Solutions': '+919999000002',
    'Cable World': '+919999000003',
    'Electrical Store': '+919999000004',
    'Fan Hub': '+919999000005',
    'Wire Solutions': '+919999000006',
    'Bright Lights Co': '+919999000007',
    'Starlite': '+919999000008',
    'Breaker Mart': '+919999000009',
    'Conduit Depot': '+919999000010',
    'Tool House': '+919999000011',
    'Motor Sales': '+919999000012',
    'Panel Point': '+919999000013',
    'SecureWear': '+919999000014',
    'Solar Shop': '+919999000015',
  };

  final Map<String, String> _sellerWebsiteMap = const {
    'ElectroMart': 'https://electromart.com/',
    'Power Solutions': 'https://www.powersolutions.co.in/',
    'Cable World': 'https://example.com/cable-world',
    'Electrical Store': 'https://example.com/electrical-store',
    'Fan Hub': 'https://example.com/fan-hub',
    'Wire Solutions': 'https://example.com/wire-solutions',
    'Bright Lights Co': 'https://example.com/bright-lights',
    'Starlite': 'https://example.com/starlite',
    'Breaker Mart': 'https://example.com/breaker-mart',
    'Conduit Depot': 'https://example.com/conduit-depot',
    'Tool House': 'https://example.com/tool-house',
    'Motor Sales': 'https://example.com/motor-sales',
    'Panel Point': 'https://example.com/panel-point',
    'SecureWear': 'https://example.com/securewear',
    'Solar Shop': 'https://example.com/solar-shop',
  };

  String _imagePathOf(Map<String, dynamic> product) {
    final dynamic path = product['image'];
    if (path is String && path.isNotEmpty) return path;
    return 'assets/images/product-1.jpg';
  }

  void _viewProduct(Map<String, dynamic> product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(product: product, allProducts: products),
      ),
    );
  }

  void _contactSeller(Map<String, dynamic> product) {
    final String seller = (product['seller'] ?? '').toString();
    final String phone = (product['phone'] ?? _sellerPhoneMap[seller] ?? '+911234567890').toString();
    launchUrl(Uri.parse('tel:$phone'));
  }

  void _whatsappSeller(Map<String, dynamic> product) {
    final String seller = (product['seller'] ?? '').toString();
    final String phone = (product['phone'] ?? _sellerPhoneMap[seller] ?? '+911234567890').toString();
    final String message = Uri.encodeComponent('Hi, I am interested in ${product['name']}');
    final Uri wa = Uri.parse('https://wa.me/${phone.replaceAll('+', '')}?text=$message');
    launchUrl(wa, mode: LaunchMode.externalApplication);
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

    // Brand (seller)
    if (_selectedBrand != 'All Brands') {
      results = results.where((p) => p['seller'] == _selectedBrand).toList();
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
        // Keep original order
        break;
    }

    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          // Unified Navigation
          UnifiedNavigation(
            currentPage: 'search',
            isMobile: ResponsiveHelper.isMobile(context),
          ),
          
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(ResponsiveHelper.getResponsivePadding(context, mobile: 16, tablet: 20, desktop: 24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Search Products',
                    style: GoogleFonts.manrope(
                      fontSize: ResponsiveHelper.getResponsiveFontSize(context, mobile: 24, tablet: 28, desktop: 32),
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Find the best electrical products and materials',
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFF1F5F9),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF1E293B).withOpacity(0.04),
                          spreadRadius: 0,
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search products, brands, or sellers...',
                        hintStyle: GoogleFonts.manrope(color: const Color(0xFF94A3B8)),
                        prefixIcon: const Icon(Ionicons.search_outline, color: Color(0xFF64748B)),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      ),
                      onChanged: (value) => setState(() {}),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Filters Row
                  Row(
                    children: [
                      // Category Filter
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFFF1F5F9),
                              width: 1,
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedCategory,
                              isExpanded: true,
                              icon: const Icon(Ionicons.chevron_down_outline, color: Color(0xFF64748B)),
                              style: GoogleFonts.manrope(
                                color: const Color(0xFF1E293B),
                                fontSize: 14,
                              ),
                              items: [
                                'All Categories',
                                'Switches & Sockets',
                                'Wires & Cables',
                                'MCB & RCCB',
                                'LED Lights',
                                'Fans',
                                'Pumps',
                                'Tools',
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedCategory = newValue!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      
                      // Sort By Filter
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFFF1F5F9),
                            width: 1,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedSortBy,
                            icon: const Icon(Ionicons.chevron_down_outline, color: Color(0xFF64748B)),
                            style: GoogleFonts.manrope(
                              color: const Color(0xFF1E293B),
                              fontSize: 14,
                            ),
                            items: [
                              'Best match',
                              'Lowest price',
                              'Highest price',
                              'Verified sellers first',
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedSortBy = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      
                      // View Toggle
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFFF1F5F9),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildViewToggleButton(Ionicons.grid_outline, true),
                            _buildViewToggleButton(Ionicons.list_outline, false),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Results Count
                  Text(
                    '${filteredProducts.length} products found',
                    style: GoogleFonts.manrope(
                      fontSize: 14,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Products Grid
                  if (_isGridView)
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: ResponsiveHelper.getResponsiveColumns(context, mobile: 2, tablet: 3, desktop: 4),
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.8,
                      ),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return _buildProductCard(product);
                      },
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return _buildProductListItem(product);
                      },
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewToggleButton(IconData icon, bool isGrid) {
    final isSelected = _isGridView == isGrid;
    return GestureDetector(
      onTap: () {
        setState(() {
          _isGridView = isGrid;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3B82F6) : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : const Color(0xFF64748B),
          size: 20,
        ),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFF1F5F9),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E293B).withOpacity(0.04),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF8FAFC),
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                _imagePathOf(product),
                fit: BoxFit.contain,
                errorBuilder: (context, error, stack) {
                  return Image.asset(
                    'assets/images/product-1.jpg',
                    fit: BoxFit.contain,
                  );
                },
              ),
            ),
          ),
          
          // Product Info
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name'],
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E293B),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'by ',
                  style: GoogleFonts.manrope(fontSize: 12, color: const Color(0xFF64748B)),
                ),
                _CompanyLink(
                  text: product['seller'],
                  url: _sellerWebsiteMap[(product['seller'] ?? '').toString()] ?? 'https://example.com',
                ),
                const SizedBox(height: 8),
                Text(
                  '₹${product['price'].toString().replaceAll('₹', '')}',
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF3B82F6),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    OutlinedButton(
                      onPressed: () => _viewProduct(product),
                      child: const Text('View Product'),
                    ),
                    OutlinedButton(
                      onPressed: () => _contactSeller(product),
                      child: const Text('Contact Seller'),
                    ),
                    ElevatedButton(
                      onPressed: () => _whatsappSeller(product),
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF25D366)),
                      child: const Text('WhatsApp'),
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

  Widget _buildProductListItem(Map<String, dynamic> product) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFF1F5F9),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E293B).withOpacity(0.04),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(8),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
              _imagePathOf(product),
              fit: BoxFit.contain,
              errorBuilder: (context, error, stack) {
                return Image.asset(
                  'assets/images/product-1.jpg',
                  fit: BoxFit.contain,
                );
              },
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
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'by ',
                  style: GoogleFonts.manrope(fontSize: 14, color: const Color(0xFF64748B)),
                ),
                _CompanyLink(
                  text: product['seller'],
                  url: _sellerWebsiteMap[(product['seller'] ?? '').toString()] ?? 'https://example.com',
                ),
                const SizedBox(height: 8),
                Text(
                  '₹${product['price'].toString().replaceAll('₹', '')}',
                  style: GoogleFonts.manrope(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF3B82F6),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    OutlinedButton(
                      onPressed: () => _viewProduct(product),
                      child: const Text('View Product'),
                    ),
                    ElevatedButton(
                      onPressed: () => _whatsappSeller(product),
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF25D366)),
                      child: const Text('WhatsApp'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Inline CTAs above replace separate right-side button
        ],
      ),
    );
  }

  // Sample products data
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Philips LED Bulb 9W',
      'seller': 'ElectroMart',
      'price': '₹120',
      'priceValue': 120,
      'category': 'LED Lights',
      'type': 'Product',
      'sellerType': 'Pro',
      'state': 'Maharashtra',
      'rating': 4.5,
      'reviews': 128,
      'description': 'Energy efficient LED bulb with warm white light',
      'image': 'assets/images/lights/philips_bulb_single_white_bg.jpeg',
    },
    {
      'name': 'Havells MCB 32A',
      'seller': 'Power Solutions',
      'price': '₹450',
      'priceValue': 450,
      'category': 'MCB & RCCB',
      'type': 'Product',
      'sellerType': 'Plus',
      'state': 'Delhi',
      'rating': 4.2,
      'reviews': 89,
      'description': 'Miniature Circuit Breaker for electrical protection',
      'image': 'assets/images/circuit-breakers/electric_mcb_60w_single_white_bg.jpeg',
    },
    {
      'name': 'Finolex Cable 2.5mm',
      'seller': 'Cable World',
      'price': '₹2800',
      'priceValue': 2800,
      'category': 'Wires & Cables',
      'type': 'Material',
      'sellerType': 'Free',
      'state': 'Karnataka',
      'rating': 4.0,
      'reviews': 156,
      'description': 'Copper wire cable for electrical wiring',
      'image': 'assets/images/wires-and-cables/wires1.jpeg',
    },
    {
      'name': 'Anchor Switch Socket',
      'seller': 'Electrical Store',
      'price': '₹85',
      'priceValue': 85,
      'category': 'Switches & Sockets',
      'type': 'Product',
      'sellerType': 'Pro',
      'state': 'Tamil Nadu',
      'rating': 4.3,
      'reviews': 203,
      'description': 'Modular switch socket with safety features',
      'image': 'assets/images/switches/electric_switch_white_bg.jpeg',
    },
    {
      'name': 'Crompton Fan 1200mm',
      'seller': 'Fan Hub',
      'price': '₹2200',
      'priceValue': 2200,
      'category': 'Fans',
      'type': 'Product',
      'sellerType': 'Plus',
      'state': 'Gujarat',
      'rating': 4.1,
      'reviews': 67,
      'description': 'Ceiling fan with energy efficient motor',
      'image': 'assets/images/product-4.jpg',
    },
    {
      'name': 'Polycab Wire 1.5mm',
      'seller': 'Wire Solutions',
      'price': '₹1800',
      'priceValue': 1800,
      'category': 'Wires & Cables',
      'type': 'Material',
      'sellerType': 'Free',
      'state': 'Rajasthan',
      'rating': 3.8,
      'reviews': 94,
      'description': 'Electrical wire for domestic wiring',
      'image': 'assets/images/wires-and-cables/wires1.jpeg',
    },
    {
      'name': 'LED Tube Light 60W',
      'seller': 'Bright Lights Co',
      'price': '₹180',
      'priceValue': 180,
      'category': 'LED Lights',
      'type': 'Product',
      'sellerType': 'Plus',
      'state': 'Haryana',
      'rating': 4.6,
      'reviews': 142,
      'description': 'Energy-efficient tube light for homes and offices',
      'image': 'assets/images/lights/tube_lights_60w_single_white_bg.jpeg',
    },
    {
      'name': 'Event Light 60W',
      'seller': 'Starlite',
      'price': '₹250',
      'priceValue': 250,
      'category': 'LED Lights',
      'type': 'Product',
      'sellerType': 'Free',
      'state': 'Kerala',
      'rating': 4.4,
      'reviews': 78,
      'description': 'Compact event light suitable for parties and events',
      'image': 'assets/images/lights/event_lights_60w_single_white_bg.jpeg',
    },
    {
      'name': 'Mini Circuit Breaker 10A',
      'seller': 'Breaker Mart',
      'price': '₹320',
      'priceValue': 320,
      'category': 'MCB & RCCB',
      'type': 'Product',
      'sellerType': 'Pro',
      'state': 'Uttar Pradesh',
      'rating': 4.3,
      'reviews': 112,
      'description': 'Reliable protection for household circuits',
      'image': 'assets/images/circuit-breakers/circuit_breakers_single_white_bg.jpeg',
    },
    {
      'name': 'Industrial Conduit 25mm',
      'seller': 'Conduit Depot',
      'price': '₹45/m',
      'priceValue': 45,
      'category': 'Tools',
      'type': 'Material',
      'sellerType': 'Free',
      'state': 'Madhya Pradesh',
      'rating': 4.1,
      'reviews': 63,
      'description': 'Durable PVC conduit pipe for industrial use',
      'image': 'assets/images/conduits/conduit1.jpeg',
    },
    {
      'name': 'Insulated Screwdriver Set',
      'seller': 'Tool House',
      'price': '₹399',
      'priceValue': 399,
      'category': 'Tools',
      'type': 'Product',
      'sellerType': 'Plus',
      'state': 'Punjab',
      'rating': 4.3,
      'reviews': 84,
      'description': 'Set of insulated screwdrivers for electrical work',
      'image': 'assets/images/tools/tool1.jpeg',
    },
    {
      'name': 'Industrial Motor 2HP',
      'seller': 'Motor Sales',
      'price': '₹8990',
      'priceValue': 8990,
      'category': 'Pumps',
      'type': 'Product',
      'sellerType': 'Pro',
      'state': 'Telangana',
      'rating': 4.6,
      'reviews': 51,
      'description': 'High-efficiency 2HP industrial motor',
      'image': 'assets/images/motors/motor1.jpeg',
    },
    {
      'name': 'Distribution Panel Box',
      'seller': 'Panel Point',
      'price': '₹12500',
      'priceValue': 12500,
      'category': 'Fans',
      'type': 'Product',
      'sellerType': 'Pro',
      'state': 'West Bengal',
      'rating': 4.5,
      'reviews': 39,
      'description': 'Metal distribution panel for safe power management',
      'image': 'assets/images/panels/panel1.jpeg',
    },
    {
      'name': 'Safety Gloves',
      'seller': 'SecureWear',
      'price': '₹199',
      'priceValue': 199,
      'category': 'Tools',
      'type': 'Product',
      'sellerType': 'Free',
      'state': 'Odisha',
      'rating': 4.2,
      'reviews': 64,
      'description': 'Protective gloves for electrical safety',
      'image': 'assets/images/safety/safety1.jpeg',
    },
    {
      'name': 'Three-Core Cable 4mm',
      'seller': 'Cable World',
      'price': '₹240/m',
      'priceValue': 240,
      'category': 'Wires & Cables',
      'type': 'Material',
      'sellerType': 'Plus',
      'state': 'Maharashtra',
      'rating': 4.2,
      'reviews': 73,
      'description': 'Durable three-core copper cable for wiring',
      'image': 'assets/images/wires-and-cables/wires2.jpeg',
    },
    {
      'name': 'Solar Charge Controller',
      'seller': 'Solar Shop',
      'price': '₹1899',
      'priceValue': 1899,
      'category': 'LED Lights',
      'type': 'Product',
      'sellerType': 'Plus',
      'state': 'Rajasthan',
      'rating': 4.4,
      'reviews': 41,
      'description': 'PWM solar charge controller for panels',
      'image': 'assets/images/transformer/solar_controller.jpeg',
    },
    {
      'name': 'LED Street Light 60W',
      'seller': 'Bright Lights Co',
      'price': '₹1499',
      'priceValue': 1499,
      'category': 'LED Lights',
      'type': 'Product',
      'sellerType': 'Pro',
      'state': 'Gujarat',
      'rating': 4.5,
      'reviews': 58,
      'description': 'Weatherproof LED street light with long life',
      'image': 'assets/images/lights/street_light_60w_single_white_bg.jpeg',
    },
    {
      'name': 'Smart Power Strip 4-Socket',
      'seller': 'ElectroMart',
      'price': '₹999',
      'priceValue': 999,
      'category': 'Switches & Sockets',
      'type': 'Product',
      'sellerType': 'Plus',
      'state': 'Karnataka',
      'rating': 4.1,
      'reviews': 76,
      'description': 'Surge-protected 4-socket strip with master switch',
      'image': 'assets/images/product-1.jpg',
    },
    {
      'name': 'Heavy Duty Extension Cord 5m',
      'seller': 'Power Solutions',
      'price': '₹349',
      'priceValue': 349,
      'category': 'Wires & Cables',
      'type': 'Product',
      'sellerType': 'Free',
      'state': 'Tamil Nadu',
      'rating': 4.0,
      'reviews': 51,
      'description': '5 meter extension cable with PVC insulation',
      'image': 'assets/images/product-2.jpg',
    },
    {
      'name': 'Digital Multimeter',
      'seller': 'Tool House',
      'price': '₹799',
      'priceValue': 799,
      'category': 'Tools',
      'type': 'Product',
      'sellerType': 'Pro',
      'state': 'Delhi',
      'rating': 4.4,
      'reviews': 133,
      'description': 'Portable multimeter for voltage, current and resistance',
      'image': 'assets/images/product-3.jpg',
    },
    {
      'name': 'Solar Panel 250W',
      'seller': 'Solar Shop',
      'price': '₹6500',
      'priceValue': 6500,
      'category': 'LED Lights',
      'type': 'Product',
      'sellerType': 'Plus',
      'state': 'Rajasthan',
      'rating': 4.3,
      'reviews': 62,
      'description': 'High efficiency polycrystalline solar module',
      'image': 'assets/images/product-4.jpg',
    },
    {
      'name': 'PVC Insulation Tape (10pc)',
      'seller': 'Wire Solutions',
      'price': '₹129',
      'priceValue': 129,
      'category': 'Tools',
      'type': 'Product',
      'sellerType': 'Free',
      'state': 'Uttar Pradesh',
      'rating': 4.2,
      'reviews': 47,
      'description': 'Set of 10 durable insulation tapes for wiring',
      'image': 'assets/images/tools/tool1.jpeg',
    },
    {
      'name': 'MCB Distribution Box 8-Way',
      'seller': 'Panel Point',
      'price': '₹1790',
      'priceValue': 1790,
      'category': 'MCB & RCCB',
      'type': 'Product',
      'sellerType': 'Pro',
      'state': 'Maharashtra',
      'rating': 4.5,
      'reviews': 38,
      'description': 'Metal enclosure distribution box with neutral link',
      'image': 'assets/images/panels/panel1.jpeg',
    },
    {
      'name': 'Safety Helmet (Electrical Grade)',
      'seller': 'SecureWear',
      'price': '₹349',
      'priceValue': 349,
      'category': 'Tools',
      'type': 'Product',
      'sellerType': 'Plus',
      'state': 'Gujarat',
      'rating': 4.1,
      'reviews': 59,
      'description': 'ISI marked helmet suitable for electrical works',
      'image': 'assets/images/safety/safety1.jpeg',
    },
  ];
}

class _CompanyLink extends StatelessWidget {
  final String text;
  final String url;
  const _CompanyLink({required this.text, required this.url});

  @override
  Widget build(BuildContext context) {
    final Uri uri = Uri.parse(url);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => launchUrl(uri, mode: LaunchMode.externalApplication),
        child: Text(
          text,
          style: GoogleFonts.manrope(
            fontSize: 12,
            color: const Color(0xFF1D4ED8),
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
